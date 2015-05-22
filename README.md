# ActiveRecord Stand-alone Migrations

Allows you to use ActiveRecord migrations in non-Rails projects.

This branch is for the _optimistic_ version, assuming the internals of AR migrations we rely on
won't change until the next major version. However, we can't really promiss the related AR
migrations code won't change in minor or patch versions of AR. That's why we can't release this
branch as a final version.

But at least you should be able to try it with basically any AR version in case you have to deal
with conflicts.

## Installation

Add this line to your application's Gemfile (run `bundle init` if you don't have one):

    gem 'active_record_migrations', '4.0.0.0.pre.optimistic'
    gem 'sqlite3' # or 'pg', 'mysql2', ...

And then execute:

    $ bundle --binstubs

Create a Rakefile:

    require 'active_record_migrations'
    ActiveRecordMigrations.load_tasks

## Usage

By default, your database configurations will be read from `db/config.yml` and your migration files
will be created under `db/migrate`. If you want to keep with the defaults, create your `db/config.yml`:

```yaml
    development:
      adapter: postgresql
      database: my_db
      encoding: utf8
      host: localhost
      port: 5432
      username: noel
      password: s3cret
    test:
      adapter: sqlite3
      database: db/test.sqlite3
      pool: 5
      timeout: 5000
```

If you prefer to specify your settings in plain Ruby, add this to your Rakefile,
before calling `ActiveRecordMigrations.load_taks`:

```ruby
ActiveRecordMigrations.configure do |c|
  c.database_configuration = {
    'development' => {'adapter' => 'sqlite3', 'database' => 'db/custom.sqlite3'},
  }
  # Other settings:
  c.schema_format = :sql # default is :ruby
  # c.yaml_config = 'db/config.yml'
  # c.environment = ENV['db']
  # c.db_dir = 'db'
  # c.migrations_paths = ['db/migrate'] # the first entry will be used by the generator
end
```

Take a look at the [Migrations Guide](http://guides.rubyonrails.org/migrations.html) for more details.

The main difference is that instead of `rails generate migration` (or `rails g migration`), the generator is
implemented as a Rake task. So you should use it like `rake "db:new_migration[CreateUser, name birth:date]"`
(double quotes are required if you use this form). Alternatively you could run it as
`rake db:new_migration name=CreateUser options="name birth:date"`.

Just run `rake db:new_migration` for help on usage.

You can specify the environment by setting the `db` environment variable:

    rake db:migrate db=production

## Versioning

For final releases, the version follows ActiveRecord versions plus a patch version from our own.
For instance, if AR version is 4.0.1, this gem will be versioned 4.0.1.x with x starting in 0.

This branch however won't use pessimistic locking so that you have some flexibility if you need.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
