require_relative "bare_minimum_checks/version"
require_relative 'bare_minimum_checks/project'
require 'yaml'

module BareMinimumChecks
    class SafePush
      def run_specs
        config = YAML.load(File.open("sample_jobber.yml"))
        puts config
        project = BareMinimumChecks::Project.new(config)
        puts project.get_test_files
        # project.run_specs
      end
    end
end
