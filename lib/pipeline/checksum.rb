module Pipeline
  class Checksum < Base
    private

    def execute
      @options.merge!("file_digest" => file_digest)
      halt!("Document already exists") if document_exists?

      @options
    end

    def file_digest
      @file_digest ||= Digest::SHA256.file(@options["file_path"]).hexdigest
    end

    def document_exists?
      document_repo.exists?(file_digest)
    end

    def document_repo
      @options["document_repo"]
    end
  end
end
