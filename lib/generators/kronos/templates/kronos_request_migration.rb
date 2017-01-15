class CreateKronosRequests < ActiveRecord::Migration
  def change
    create_table :kronos_requests do |t|
      t.string :request_params
      t.string :request_method
      t.string :remote_ip
      t.integer :duration
      t.string :controller
      t.string :action

      t.references :kronos_fragment

      t.timestamps null: false
    end
  end
end
