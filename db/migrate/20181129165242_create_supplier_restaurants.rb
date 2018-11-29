class CreateSupplierRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :supplier_restaurants do |t|
      t.references :supplier
      t.references :restaurant
      t.integer :customer_number
      t.timestamps
    end
  end
end
