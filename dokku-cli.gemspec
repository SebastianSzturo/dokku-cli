# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dokku_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "dokku-cli"
  spec.version       = DokkuCli::VERSION
  spec.authors       = ["Sebastian Szturo"]
  spec.email         = ["s.szturo@me.com"]
  spec.description   = "Command line tool for Dokku."
  spec.summary       = "Command line tool for Dokku."
  spec.homepage      = "http://github.com/SebastianSzturo/dokku-cli"
  spec.license       = "MIT"

  spec.files         = Dir["{bin,lib}/**/*"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19"
  spec.add_development_dependency "bundler", "~> 1.7"
end
