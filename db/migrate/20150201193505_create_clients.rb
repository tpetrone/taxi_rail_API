class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :phone
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
