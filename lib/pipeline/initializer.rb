module Pipeline
  class Initializer < Base
    def self.repos
      @repos ||= {
        "book_repo" => BookRepository.new,
        "author_repo" => AuthorRepository.new,
        "version_repo" => VersionRepository.new,
        "document_repo" => DocumentRepository.new,
      }
    end

    private

    def execute
      @options.merge!(self.class.repos)
      halt!("File not found") unless file_exists?

      @options
    end

    def file_exists?
      File.exists?(@options["file_path"].to_s)
    end
  end
end
