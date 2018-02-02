class Book < Hanami::Entity
  def author_name
    author.name
  end
end
