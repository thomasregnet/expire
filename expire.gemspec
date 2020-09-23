
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

  spec.add_dependency 'activesupport'
  # spec.add_dependency 'tty-box', '~> 0.4.1'
  spec.add_dependency 'tty-color', '~> 0.5'
  # spec.add_dependency 'tty-command', '~> 0.9.0'
  #spec.add_dependency 'tty-config', '~> 0.3.2'
  #spec.add_dependency 'tty-cursor', '~> 0.7'
  #spec.add_dependency 'tty-editor', '~> 0.5'
  spec.add_dependency 'tty-file', '~> 0.10'
  #spec.add_dependency 'tty-font', '~> 0.4.0'
  #spec.add_dependency 'tty-logger', '~> 0.2.0'
  # tty-markdown depends on an old version of kramdown. This old kramdown
  # has an vulnerability. Since we don't need markdown simple comment it out.
  # spec.add_dependency 'tty-markdown', '~> 0.6.0'
  #spec.add_dependency 'tty-pager', '~> 0.12'
  #spec.add_dependency 'tty-pie', '~> 0.3.0'
  #spec.add_dependency 'tty-platform', '~> 0.2'
  #spec.add_dependency 'tty-progressbar', '~> 0.17'
  # spec.add_dependency 'tty-prompt', '~> 0.19'
  spec.add_dependency 'tty-screen', '~> 0.7'
  spec.add_dependency 'tty-spinner', '~> 0.9'
  # spec.add_dependency 'tty-table', '~> 0.11.0'
  spec.add_dependency 'tty-tree', '~> 0.3'
  spec.add_dependency 'tty-which', '~> 0.4'
  spec.add_dependency 'pastel', '~> 0.8'
  spec.add_dependency 'thor'
  spec.add_dependency 'zeitwerk'

  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
end
