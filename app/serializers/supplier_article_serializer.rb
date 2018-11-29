class SupplierArticleSerializer < ArticleSerializer
  attributes :price, :art_nr, :supplier_name

  def name
    object.article.name
  end

  def supplier_name
    object.supplier.name
  end
end
