module Extraction
  class Unzip
    def initialize(dir)
      @dir = dir
    end

    def call
      Dir.glob(Pathname(@dir).join("*.zip")).each do |archive|
        system "unzip", "-u", archive, "-d", output_dir
      end

      Pathname(output_dir)
    end

    def output_dir
      @output_dir ||= Dir.mktmpdir
    end
  end
end
