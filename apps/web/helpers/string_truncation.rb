module Web::Helpers
  module StringTruncation
    private

    def truncate(string, limit = 25)
      string = string.to_s
      if string.size <= limit
        string.dup
      else
        "#{string[0,limit]} ..."
      end
    end
  end
end
