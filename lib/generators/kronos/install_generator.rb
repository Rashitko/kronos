require 'rails/generators/active_record'

module Kronos
  class InstallGenerator < ::Rails::Generators::Base

    include ActiveRecord::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    def create_migration_file
      migration_template 'kronos_fragment_migration.rb', 'db/migrate/create_kronos_fragments.rb'
      migration_template 'kronos_request_migration.rb', 'db/migrate/create_kronos_requests.rb'
      migration_template 'kronos_log_entry_migration.rb', 'db/migrate/create_kronos_log_entries.rb'
      generate 'counter_culture', 'KronosFragment kronos_requests_count' if kronos_requests_count_migration_missing?
      generate 'counter_culture', 'KronosRequest kronos_log_entries_count' if kronos_log_entries_count_migration_missing?
      template 'kronos_config.rb', 'config/initializers/kronos.rb'
    end

    private
    def kronos_requests_count_migration_missing?
      Dir.glob('db/migrate/*add_kronos_requests_count*.rb').empty?
    end

    def kronos_log_entries_count_migration_missing?
      Dir.glob('db/migrate/*add_kronos_log_entries_count*.rb').empty?
    end

  end
end