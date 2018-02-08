module Pipeline
  class Create
    def self.call(options)
      options = Pipeline::Initializer.call(options)
      options = Pipeline::Checksum.call(options)
      options = Pipeline::FileMetadata.call(options)
      options = Pipeline::IsbnFromFile.call(options)
      options = Pipeline::IsbnMetadata.call(options)
      options = Pipeline::AddAuthor.call(options)
      options = Pipeline::AddBook.call(options)
      options = Pipeline::AddVersion.call(options)
      options = Pipeline::AddDocument.call(options)
      options

    rescue => error
      options["error"] = {
        "name" => error.class.name,
        "backtrace" => error.backtrace,
        "message" => error.message
      }

    ensure
      data = options.reject do |key, val|
        val.is_a?(Hanami::Entity) || val.is_a?(Hanami::Repository)
      end

      ImportLogRepository.new.create(data: data)
    end
  end
end
