require_relative "./base"

module Pipeline
  class AddDocument < Base
    private

    def execute
      document = create_document
      @options["document"] = document
      @options["document_id"] = document.id
    end

    def create_document
      repo.create(Document.new(document_attributes))
    end

    def document_attributes
      {
        version_id: @options["version_id"],
        sha_hash: @options["file_digest"],
        file: File.open(@options["file_path"]),
      }
    end

    def repo
      @options["document_repo"]
    end
  end
end
