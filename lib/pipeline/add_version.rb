require_relative "./base"

module Pipeline
  class AddVersion < Base
    private

    def execute
      version = create_version
      @options["version"] = version
      @options["version_id"] = version.id
    end

    def create_version
      repo.create(version_attributes)
    end

    def version_attributes
      {
        book_id: @options["book_id"],
        type: fetch_type,
        published_at: @options["published_at"],
      }
    end

    def fetch_type
      MIME::Types
        .of(@options["file_path"])
        .map(&:preferred_extension)
        .first
    end

    def repo
      @options["version_repo"]
    end
  end
end
