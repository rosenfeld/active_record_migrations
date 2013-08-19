require 'singleton'
require 'yaml'

module ActiveRecordMigrations
  class Configurations
    include Singleton

    attr_accessor :yaml_config, :database_configuration, :environment, :db_dir, :schema_format, :seed_loader

    def initialize
      @yaml_config = 'db/config.yml'
      @environment = ENV['db'] || Rails.env
      @db_dir = 'db'
      @schema_format = :ruby # or :sql
      @seed_loader = Rails.application
    end

    alias configure instance_eval

    def database_configuration
      @database_configuration ||= YAML.load(File.read @yaml_config)
    end
  end
end

