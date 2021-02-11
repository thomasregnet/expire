
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "expire/version"

Gem::Specification.new do |spec|
  spec.name          = "expire"
  spec.version       = Expire::VERSION
  spec.authors       = ["Thomas Regnet"]
  # spec.email         = ["TODO: Write your email address"]

  spec.summary       = %q{Calculate expired backups.}
  spec.homepage      = 'https://github.com/thomasregnet/expire'
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section
  # to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '~> 6.1'
  spec.add_dependency 'pastel', '~> 0.8'
  spec.add_dependency 'thor', '~> 1.1'
  spec.add_dependency 'zeitwerk', "~> 2.4"

  spec.add_development_dependency 'aruba', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'byebug', '~> 11.1'
  spec.add_development_dependency 'cucumber', '~> 5.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'reek', '~> 6.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.9'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.2'
  spec.add_development_dependency 'simplecov', '~> 0.21'
end
