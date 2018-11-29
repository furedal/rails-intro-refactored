class SupplierRestaurantSerializer < RestaurantSerializer
  attributes :customer_number

  def name
    object.restaurant.name
  end
end
