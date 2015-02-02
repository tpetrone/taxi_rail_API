class CreateCorridas < ActiveRecord::Migration
  def change
    create_table :corridas do |t|
      t.integer :client_id
      t.integer :driver_id
      t.string :address

      t.timestamps null: false
    end
  end
end
