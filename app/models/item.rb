class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_duration
  has_one_attached :image
  
  with_options presence: true do
    validates :name, :description, :price, :user, :image
  end

  with_options numericality: { other_than: 0 } do
    validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_duration_id
  end
end
