class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postcode, :prefecture_id, :city, :block, :building, :phone, :token

  POSTCODE_REGEX = /\A\d{3}-\d{4}\z/
  PHONE_REGEX = /\A\d{10,11}\z/

  with_options presence: true do
    validates :item_id, :user_id, :city, :block, :token
    validates :postcode, format: { with: POSTCODE_REGEX, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :phone, format: { with: PHONE_REGEX, message: 'is invalid. Enter it as follows(e.g. 09012345678)' }
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone: phone, order_id: order.id) # rubocop:disable Layout/LineLength
  end
end