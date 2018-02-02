module Extraction
  class Extractor
    attr_reader :dir

    def initialize(dir)
      @dir = Pathname(dir)
      @output_dir = nil
    end

    def call
      if has_zips?(dir)
        @output_dir = Unzip.new(dir).call
        @output_dir = Unrar.new(@output_dir).call if has_rars?(@output_dir)
      elsif has_rars?(dir)
        @output_dir = Unrar.new(dir).call
        @output_dir = Unzip.new(@output_dir).call if has_zips?(@output_dir)
      else
        dir
      end
    end

    def has_files?(dir, pattern)
      dir.entries.any? { |file| file.to_s.end_with?(pattern) }
    end

    def has_zips?(dir)
      has_files?(dir, ".zip")
    end

    def has_rars?(dir)
      has_files?(dir, ".rar")
    end
  end
end
