require_relative "bare_minimum_checks/version"
require_relative 'bare_minimum_checks/project'

module BareMinimumChecks
    class SafePush
      def run_specs
        project = BareMinimumChecks::Project.new
        project.run_specs
      end
    end
end


