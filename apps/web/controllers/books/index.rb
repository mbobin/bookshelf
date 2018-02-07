module Web::Controllers::Books
  class Index
    include Web::Action

    expose :books

    def call(params)
      @books = BookRepository.new.all_with_author
    end

    def description_for(book)
      truncate book.description, 500
    end
  end
end
