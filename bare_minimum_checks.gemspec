#
# lib = File.expand_path("../lib", __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# $LOAD_PATH.unshift("/Users/pavithra/.rvm/gems/ruby-2.3.8/gems")
# puts $LOAD_PATH
require "bare_minimum_checks/version"

Gem::Specification.new do |spec|
  spec.name          = "bare_minimum_checks"
  spec.version       = BareMinimumChecks::VERSION
  spec.authors       = ["Pavithra Krishnan"]
  spec.email         = ["pavikrish2988@gmail.com"]

  spec.summary       = "Run tests for files modified"
  spec.description   = "Provides a cli to run tests for the files that have been modified"
  spec.license       = "MIT"
  spec.add_dependency "git", "1.5.0"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["source_code_uri"] = "https://github.com/Pavithrak/bare_minimum_checks"
    spec.metadata["changelog_uri"] = "https://github.com/Pavithrak/bare_minimum_checks"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["bare_minimum_checks"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
