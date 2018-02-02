module Extraction
  class Unrar
    def initialize(dir)
      @dir = dir
    end

    def call
      Dir.glob(Pathname(@dir).join("*.rar")).each do |archive|
        system "unrar", "e", archive, output_dir
      end

      Pathname(output_dir)
    end

    def output_dir
      @output_dir ||= Dir.mktmpdir
    end
  end
end
