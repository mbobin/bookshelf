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

  def cluster
    books
      .read("select word, count(word) as frequency from(select(unnest(tags)) \
        as word from books) words group by word order by 2 desc limit 25")
      .as(CloudWord)
      .to_a
  end
end
