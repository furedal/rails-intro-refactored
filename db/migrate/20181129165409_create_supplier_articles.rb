class CreateSupplierArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :supplier_articles do |t|
      t.references :article
      t.references :supplier
      t.integer :price
      t.integer :art_nr
      t.timestamps
    end
  end
end
