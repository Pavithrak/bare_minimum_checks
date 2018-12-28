require "bare_minimum_checks/version"
require 'bare_minimum_checks/project'

module BareMinimumChecks
    class SafePush
      def run_specs
        project = BareMinimumChecks::Project.new
        puts project.local_changes
      end
    end
end


