require_relative "bare_minimum_checks/version"
require_relative 'bare_minimum_checks/project'
require 'yaml'

module BareMinimumChecks
    class SafePush
      def run_specs
        unless File.file?("sample_jobber.yml")
          puts "Please create a sample_jobber.yml file"
          return
        end
        config = YAML.load(File.open("sample_jobber.yml"))
        puts config
        project = BareMinimumChecks::Project.new(config)
        test_files = project.get_test_files
        project.run_tests test_files
      end
    end
end
