class SupplierArticle < ApplicationRecord
  belongs_to :supplier
  belongs_to :article
end
