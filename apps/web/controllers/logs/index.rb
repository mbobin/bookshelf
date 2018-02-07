module Web::Controllers::Logs
  class Index
    include Web::Action
    expose :logs

    def call(params)
      @logs = ImportLogRepository.new.from_last_to_first
    end
  end
end
