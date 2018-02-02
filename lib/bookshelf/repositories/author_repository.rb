class AuthorRepository < Hanami::Repository
  associations do
    has_many :books
  end

  def find_by_name(string)
    authors.where(name: string).one
  end
end
