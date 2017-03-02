require 'rails/generators/active_record/migration/migration_generator'
require 'active_record/tasks/database_tasks'

module ActiveRecordMigrations
  module Generators
    class MigrationGenerator < ::ActiveRecord::Generators::MigrationGenerator
      source_root ::ActiveRecord::Generators::MigrationGenerator.source_root

      def db_migrate_path
        ::ActiveRecord::Tasks::DatabaseTasks.migrations_paths.first
      end
    end
  end
end

