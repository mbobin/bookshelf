class BookRepository < Hanami::Repository
  associations do
    belongs_to :author
    has_many :versions
  end

  def all_with_author
    aggregate(:author).as(Book).to_a
  end

  def find_by_isbn(string)
    find_by(:isbn, string)
  end

  def find_by_name(string)
    find_by(:name, string)
  end

  def find_by(attribute, value)
    books.where(attribute => value).one
  end
end
