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
  # spec.add_dependency "railties", "~> 4.2.6"
  # spec.add_dependency "activerecord", "~> 4.2.6"
  # We rely on a kind of monkey patch for allowing us to override the migrations path.
  # So it's better to fix on an specific version of AR and check if the override of
  # ActiveRecord::Generators::MigrationGenerator#create_migration_file is correct
  # before upgrading AR dependency. See ARM::Generators::MigrationGenerator impl.
  spec.add_dependency "railties", "4.2.6"
  spec.add_dependency "activerecord", "4.2.6"
end

