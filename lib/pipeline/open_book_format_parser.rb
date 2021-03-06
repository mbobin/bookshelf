class OpenBookFormatParser
  def initialize(book_data)
    @book_data = Nokogiri::XML(book_data)
    @book_data.remove_namespaces!
  end

  def title
    @book_data
      .xpath("//title")
      .map(&:text)
      .first
  end

  def author
    @book_data
      .xpath("//creator")
      .map(&:text)
      .first
  end

  def description
    @book_data
      .xpath("//description")
      .map(&:text)
      .map(&method(:sanitize))
      .join("\n")
  end

  def published_at
    date = @book_data
      .xpath("//date")
      .map(&:text)
      .first

    Date.parse(date) if date
  end

  def tags
    @book_data
      .xpath("//subject")
      .map(&:text)
      .map(&method(:sanitize))
      .map { |tag| tag[0,35] }
  end

  def isbn
    @book_data
      .css("//identifier[scheme=ISBN]")
      .map(&:text)
      .first
  end

  private

  def sanitize(text)
    Loofah.fragment(text).to_text
  end
end
