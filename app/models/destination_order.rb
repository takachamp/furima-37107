class DestinationOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :shipping_area_id, :city, :house_number, :building_number, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :shipping_area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'Input only number' }
    validates :city, :house_number, :user_id, :item_id
  end

  validates :token, presence: true

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(postal_code: postal_code, shipping_area_id: shipping_area_id, city: city, house_number: house_number,
                       phone_number: phone_number, order_id: order.id)
  end
end
