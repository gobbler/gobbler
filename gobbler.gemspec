# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gobbler/version'

Gem::Specification.new do |gem|
  gem.name          = "gobbler"
  gem.version       = Gobbler::VERSION
  gem.authors       = ["Daniel McNevin"]
  gem.email         = ["dan@gobbler.com"]
  gem.description   = %q{Access to the Gobbler API}
  gem.summary       = %q{Access to the Gobbler API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
