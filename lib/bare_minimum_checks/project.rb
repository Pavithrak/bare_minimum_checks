require 'git'
require_relative 'file_name_style'

module BareMinimumChecks
  class Project
    def run_specs
      specs = local_changes.reduce([]) do |specs, file_path|
        arr = specs.concat FileNameStyle.camel_case.get_test_file_name(file_path)
        arr.concat FileNameStyle.snake_case.get_test_file_name(file_path)
      end
      specs.each do |spec_file|
        puts "Running #{spec_file}"
        system("rspec #{spec_file}")

      end
    end

    private

    def local_changes
      g = Git.open('.')
      local_changes = g.diff.map(&:path)
      current_branch_name = g.current_branch
      branch_name = is_local_branch?(current_branch_name) ? 'origin/master' : "origin/#{current_branch_name}"
      local_changes.concat g.diff(branch_name, 'HEAD').map(&:path)
      local_changes.uniq
    end

    def is_local_branch?(branch_name)
      count = `git remote show origin | grep #{branch_name} | wc -l`
      count.to_i == 0
    end
  end
end
