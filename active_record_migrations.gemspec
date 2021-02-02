# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record_migrations/version'

Gem::Specification.new do |spec|
  spec.name          = "active_record_migrations"
  spec.version       = ActiveRecordMigrations::VERSION
  spec.authors       = ["Rodrigo Rosenfeld Rosas"]
  spec.email         = ["rr.rosas@gmail.com"]
  spec.description   = %q{ActiveRecord Stand-alone migrations}
  spec.summary       = %q{Use AR migrations from outside of a Rails project}
  spec.homepage      = "http://github.com/rosenfeld/active_record_migrations"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_dependency "rake"
  spec.add_dependency "railties", ">= 6.1.1"
  spec.add_dependency "activerecord", ">= 6.1.1"
end

