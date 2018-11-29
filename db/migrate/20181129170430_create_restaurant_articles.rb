class CreateRestaurantArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_articles do |t|
      t.references :restaurant
      t.references :article
      t.integer :selling_price
      t.timestamps
    end
  end
end
