class ImportLog < Hanami::Entity
  def success?
  end

  def fail?
    data["error"] || !(data["author_id"] && data["book_id"])
  end
end
