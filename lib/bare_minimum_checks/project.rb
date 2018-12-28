require 'git'

module BareMinimumChecks
  class Project
    def local_changes
      g = Git.open(".")
      local_changes = g.diff.map(&:path)
      branch_name = "origin/#{g.branch.name}"
      local_changes << g.diff(branch_name, 'HEAD').map(&:path)
      local_changes
    end
  end
end
