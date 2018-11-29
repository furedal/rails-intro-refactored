class Supplier::Article < ApplicationRecord
  belongs_to :supplier
  belongs_to :article, class_name: '::Article'

  delegate :name, to: :article
  delegate :name, to: :supplier, prefix: true
end
