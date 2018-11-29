class Supplier < ApplicationRecord
  has_many :restaurants
  has_many :supplier_articles
end
