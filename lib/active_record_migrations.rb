require "active_record_migrations/version"
require 'active_record'
require 'active_record/tasks/database_tasks'
require 'rails'
require 'rails/application'
require_relative 'active_record_migrations/configurations'

module ActiveRecordMigrations
  include ActiveRecord::Tasks

  def self.configure(&block)
    create_rails_app_if_not_exists
    configurations.configure &block
  end

  def self.load_tasks
    create_rails_app_if_not_exists

    load "active_record/railties/databases.rake"
    load 'active_record_migrations/tasks/new_migration.rake'

    ActiveRecord::Base.schema_format = configurations.schema_format
    DatabaseTasks.env = configurations.environment
    DatabaseTasks.seed_loader = configurations.seed_loader
    ActiveRecord::Base.configurations = DatabaseTasks.database_configuration =
      configurations.database_configuration
    DatabaseTasks.current_config = configurations.database_configuration[configurations.environment]
    DatabaseTasks.db_dir = configurations.db_dir
  end

  private

  def self.create_rails_app_if_not_exists
    Class.new(Rails::Application) unless Rails.application
  end

  def self.configurations
    Configurations.instance
  end
end

