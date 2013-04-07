# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-socialnode/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["JPH"]
  gem.email         = ["jph@ciphersys.net"]
  gem.description   = %q{Socialnode OAuth (1.0/1.0a) strategy for OmniAuth.}
  gem.summary       = %q{Socialnode OAuth (1.0/1.0a) strategy for OmniAuth. Based on omniauth-twitter}
  gem.homepage      = "https://github.com/ciphersys/omniauth-socialnode"

  s.add_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'omniauth-oauth', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-socialnode"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Socialnode::VERSION
end
