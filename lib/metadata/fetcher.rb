module Metadata
  class Fetcher
    def initialize(isbn)
      @isbn = isbn
    end

    def call
      @output = `fetch-ebook-metadata -i #{@isbn} -o`
      @output = Nokogiri::XML(@output)
      binding.pry
      @output.root.to_hash
    end
  end
end
