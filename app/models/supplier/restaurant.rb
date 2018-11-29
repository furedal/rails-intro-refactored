class Supplier::Restaurant < ApplicationRecord
  belongs_to :restaurant, class_name: '::Restaurant'
  belongs_to :supplier, optional: true

  delegate :name, to: :restaurant, prefix: true
  delegate :name, to: :supplier

  attr_accessor :name

  before_create :ensure_supplier
  def ensure_supplier
    supplier = Supplier.find_by(supplier_id: self.supplier_id) unless self.supplier_id.blank?
    supplier.create(
      name: @name
    ) unless supplier || @name.blank?

    raise Exceptions::BadRequest("Supplier is required") unless supplier
  end

end
