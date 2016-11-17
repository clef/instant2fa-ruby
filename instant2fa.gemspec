# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'instant2fa/version'

Gem::Specification.new do |spec|
  spec.name          = "instant2fa"
  spec.version       = Instant2fa::VERSION
  spec.authors       = ["Jesse Pollak"]
  spec.email         = ["jesse@instant2fa.com"]

  spec.summary       = %q{A library for using the Instant 2FA API.}
  spec.homepage      = "https://instant2fa.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec", "~> 4", ">= 4.7.3"
  spec.add_development_dependency "pry", "~> 0.10", ">= 0.10.4"

  spec.add_dependency "json_api_client", ">= 1.3.0", "<2.0.0"
  spec.add_dependency 'activesupport', ">= 3.2.0", "<5.0.0"
end
