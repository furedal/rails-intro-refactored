class Restaurant < ApplicationRecord
  has_many :suppliers, class_name: 'Supplier::Restaurant'
  has_many :articles
end
