require 'git'
require_relative 'file_name_style'

module BareMinimumChecks
  class Project
    def initialize(config)
      @config = config
    end

    def get_test_files
      find_files = @config["tests"]["find"]
      local_changes.reduce([]) do |specs, full_file_name|
        file_path = File.dirname(full_file_name)
        file_path.gsub!(find_files["strip"], ".")
        file_name = File.basename(full_file_name, ".*")
        paths = find_files["paths"]
        test_files = paths.map do |path|
          test_file = path.gsub("{path_to_file}", file_path).gsub("{file_name}", file_name)
          if File.file? test_file
            test_file
          else
            nil
          end
        end.compact
        if test_files.empty?
          puts "No test file found for #{full_file_name}"
        end
        specs.push(*test_files)
        specs
      end
    end

    def run_tests(files)
      run_config = @config["tests"]["run"]
      command = run_config["command"]
      if(command)
        puts "Running #{files}"
        system("#{command} #{files.join(" ")}")
      else
        puts "No command found to run the tests for #{files}"
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
