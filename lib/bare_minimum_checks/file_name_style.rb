module BareMinimumChecks
  class FileNameStyle
    def get_test_file_name(file_path)
      file = get_name(file_path)
      if @style.match(file)
        file_name_split = file.split('.')
        @test_file_names.reduce([]) do |arr, name|
          file_name_split[0] = file_name_split[0] + name
          dir_glob = Dir.glob("./**/#{file_name_split.join('.')}")
          arr.concat dir_glob
        end
      else
        []
      end
    end

    def self.camel_case
      FileNameStyle.new(/^([A-Z][a-z0-9]+)+\.([a-z]+)/, %w[Spec Test])
    end

    def self.snake_case
      FileNameStyle.new(/^[A-Za-z]+[_A-Za-z]+\.[a-z]+/, %w[_spec _test])
    end

    private

    def initialize(style, test_file_names)
      @style = style
      @test_file_names = test_file_names
    end

    def get_name(file_path)
      file_path.split('/')[-1]
    end
  end
end
