# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-spotify-plugin/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-spotify-plugin"
  spec.version       = Jekyll::Spotify::Plugin::VERSION
  spec.authors       = ["William Canin"]
  spec.email         = ["william.costa.canin@gmail.com"]

  spec.summary       = %q{Jekyll plugin to generate HTML code fragments to incorporate music from Spotify}
  spec.homepage      = "https://github.com/williamcanin/jekyll-spotify-plugin"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "jekyll", "~> 3.4", "~> 3.4.3"
  spec.add_dependency "sass", "~> 3.4","~> 3.4.23"
  spec.add_dependency "bootstrap-sass", "~> 3.3","~> 3.3.7"

  spec.add_development_dependency "bundler", "~> 1.14","~> 1.14.6"
  spec.add_development_dependency "rake", "~> 12.0","~> 12.0.0"
end