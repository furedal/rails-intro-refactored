class Restaurant::Article < ApplicationRecord
  belongs_to :restaurant
  belongs_to :article, class_name: '::Article'

  delegate :name, to: :article
end
