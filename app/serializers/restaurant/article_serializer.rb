class Restaurant::ArticleSerializer < ArticleSerializer
  attributes :selling_price

  has_one :restaurant
end
