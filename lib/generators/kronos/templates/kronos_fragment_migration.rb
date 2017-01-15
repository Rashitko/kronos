class CreateKronosFragments < ActiveRecord::Migration
  def change
    create_table :kronos_fragments do |t|
      t.string :request_path
      t.integer :average_duration
      t.integer :longest_duration
      t.references :longest_request

      t.timestamps null: false
    end
  end
end
