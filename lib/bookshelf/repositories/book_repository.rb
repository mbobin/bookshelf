class BookRepository < Hanami::Repository
  associations do
    belongs_to :author
    has_many :versions
  end

  def all_with_author
    aggregate(:author).as(Book).to_a
  end
end
