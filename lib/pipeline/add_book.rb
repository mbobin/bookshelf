require_relative "./base"

module Pipeline
  class AddBook < Base
    private

    def execute
      book = find_by_isbn || find_by_name || create_book
      @options["book"] = book
      @options["book_id"] = book.id
    end

    def find_by_isbn
      repo.find_by_isbn(@options["isbn"])
    end

    def find_by_name
      repo.find_by_name(@options["name"])
    end

    def create_book
      repo.create(book_attributes)
    end

    def book_attributes
      {
        author_id: @options["author_id"],
        name: @options["name"],
        description: @options["description"],
        tags: Array(@options["tags"]),
        isbn: @options["isbn"],
      }
    end

    def repo
      @options["book_repo"]
    end
  end
end
