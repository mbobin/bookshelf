require_relative "./base"

module Pipeline
  class AddAuthor < Base
    private

    def execute
      author = find_or_create_author
      @options["author"] = author
      @options["author_id"] = author.id
    end

    def author_name
      @options["author_name"] || "Unknown"
    end

    def find_or_create_author
      repo.find_by_name(author_name) || create_author
    end

    def create_author
      repo.create(name: author_name)
    end

    def repo
      @options["author_repo"]
    end
  end
end
