class RestaurantArticleSerializer < ArticleSerializer
  attributes :selling_price

  has_one :restaurant

  def name
    object.article.name
  end
end
