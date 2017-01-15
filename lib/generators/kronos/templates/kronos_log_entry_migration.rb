class CreateKronosLogEntries < ActiveRecord::Migration
  def change
    create_table :kronos_log_entries do |t|
      t.string :message
      t.integer :level

      t.references :kronos_request

      t.timestamps null: false
    end
  end
end
