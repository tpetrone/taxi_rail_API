class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :phone
      t.string :car_model
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
