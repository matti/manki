# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'manki/version'

Gem::Specification.new do |spec|
  spec.name          = "manki"
  spec.version       = Manki::VERSION
  spec.authors       = ["Matti Paksula"]
  spec.email         = ["matti.paksula@iki.fi"]

  spec.summary       = %q{Goes around your site.}
  spec.description   = %q{An alternative way to run Capybara with out without rspec}
  spec.homepage      = "http://github.com/matti/manki"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "capybara", "2.7.1"
  spec.add_runtime_dependency "poltergeist", "1.9.0"
  spec.add_runtime_dependency "capybara-selenium"

  spec.add_runtime_dependency "activesupport"


  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "rspec-autotest", "~> 1.0"
  spec.add_development_dependency "ZenTest", "~> 4.11"

  spec.add_development_dependency "simplecov", "~> 0.11"

  spec.add_development_dependency "sinatra", "~> 1.4"
  spec.add_development_dependency "kommando", "~> 0.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "pry"
end
