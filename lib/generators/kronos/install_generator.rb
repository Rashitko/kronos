require 'rails/generators/active_record'

module Kronos
  class InstallGenerator < ::Rails::Generators::Base

    include ActiveRecord::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    def create_migration_file
      migration_template 'kronos_migration.erb.rb', "db/migrate/create_kronos_fragments.rb"
    end

    def create_model_file
      copy_file 'model_kronos_fragment.rb', 'app/models/kronos_fragment.rb'
      copy_file 'admin_kronos_fragment.rb', 'app/admin/kronos_fragment.rb'
    end

  end
end