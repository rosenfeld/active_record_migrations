require 'rails/generators'
require 'active_record'
require 'active_record/tasks/database_tasks'
require 'active_record_migrations/configurations'

Rake::Task['db:load_config'].clear

task environment: 'db:load_config' do
  ActiveRecord::Base.establish_connection ActiveRecord::Tasks::DatabaseTasks.current_config
end

namespace :db do
  task(:load_config){} # db tasks depend on load_config

  desc "Creates a new migration file with the specified name"
  task :new_migration, :name, :options do |t, args|
    name = args[:name] || ENV['name']
    options = args[:options] || ENV['options']

    unless name
      generator = Rails::Generators.find_by_namespace "migration"
      desc = generator.desc.gsub(/`rails (?:g|generate) migration (\w+)`/, '`rake "db:new_migration[\\1]"`' ).
        gsub(/`rails (?:g|generate) migration (\w+) (.*)`/, '`rake "db:new_migration[\\1, \\2]"`' )
      puts [
        %Q{Usage: rake "#{t.name}[AddFieldToForm[, field[:type][:index]] field[:type][:index]]"},
        desc,
      ].join "\n\n"
      abort
    end
    params = [name]
    params.concat options.split(' ') if options
    Rails::Generators.invoke "active_record:migration", params, behavior: :invoke, destination_root: Rails.root
  end
end

