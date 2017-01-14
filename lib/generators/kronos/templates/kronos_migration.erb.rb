class CreateKronosFragments < ActiveRecord::Migration
  def change
    create_table :kronos_fragments do |t|
      t.integer :duration
      t.string :params
      t.string :request_method
      t.string :source_ip
      t.integer :response_code

      t.timestamps null: false
    end
  end
end
