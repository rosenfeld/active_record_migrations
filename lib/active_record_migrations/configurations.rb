require 'singleton'
require 'yaml'
require 'erb'

module ActiveRecordMigrations
  class Configurations
    include Singleton

    attr_accessor :yaml_config, :database_configuration, :environment, :db_dir, :migrations_paths, :schema_format, :seed_loader

    def initialize
      @yaml_config = 'db/config.yml'
      @environment = ENV['db'] || Rails.env
      @db_dir = 'db'
      @migrations_paths = ['db/migrate']
      @schema_format = :ruby # or :sql
      @seed_loader = Rails.application
    end

    alias configure instance_eval

    def database_configuration
      @database_configuration ||= YAML.load(ERB.new(File.read @yaml_config).result)
    end
  end
end

