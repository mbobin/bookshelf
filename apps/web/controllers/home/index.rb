module Web::Controllers::Home
  class Index
    include Web::Action

    def call(params)
      @tags = BookRepository.new.cluster
    end
  end
end
