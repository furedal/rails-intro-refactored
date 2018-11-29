class RestaurantSerializer < ActiveModel::Serializer
  attributes :name, :created_at, :updated_at

  has_many :articles
  has_many :suppliers
end
