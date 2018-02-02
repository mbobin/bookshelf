module Creation
  class Creator
    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

    def call
      return "File already exists #{attributes['file_path']}" if document_repo.exists?(file_digest)
      @author = find_or_create_author

      book = Book.new(book_attributes)
      book = repo.create(book)
      version = Version.new(book_id: book.id, type: attributes["type"], published_at: attributes["published_at"])
      version = version_repo.create(version)
      document = Document.new(version_id: version.id, sha_hash: file_digest, file: File.open(attributes["file_path"]))
      document = document_repo.create(document)
      document
    end

    def file_digest
      @file_digest ||= Digest::SHA256.file(attributes["file_path"]).hexdigest
    end

    def find_or_create_author
      author_repo.find_by_name(attributes["author"]) || create_author
    end

    def book_attributes
      {
        author_id: @author.id,
        name: attributes["name"],
        description: attributes["description"],
        tags: Array(attributes["tags"]),
        isbn: attributes["isbn"],
      }
    end

    def create_author
      author = Author.new(name: attributes["author"])
      author = author_repo.create(author)
      author
    end

    def repo
      @repo ||= BookRepository.new
    end

    def author_repo
      @author_repo ||= AuthorRepository.new
    end

    def version_repo
      @version_repo ||= VersionRepository.new
    end

    def document_repo
      @document_repo ||= DocumentRepository.new
    end
  end
end
