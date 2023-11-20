# frozen_string_literal: true

require_relative "lib/bridgetown-arcade-db/version"

Gem::Specification.new do |spec|
  spec.name          = "bridgetown-arcade-db"
  spec.version       = BridgetownArcadeDb::VERSION
  spec.author        = "Dr. Hartmut Bischoff"
  spec.email         = "topofocus@gmail.com"
  spec.summary       = "Plugin to add ArcadeDB support to Bridgetown sites"
  spec.homepage      = "https://github.com/topofocus/bridgetown-arcade-db"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend)/!) }
  spec.test_files    = spec.files.grep(%r!^test/!)
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.1.0"

  spec.add_dependency "bridgetown", ">= 1.2.0.beta5", "< 2.0"
  spec.add_dependency "arcadedb", ">= 0.4"
  spec.add_dependency "arcade-time-graph"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 13.0"
end
