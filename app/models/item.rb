class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_duration
  has_one_attached :image
  
  with_options presence: true do
    validates :name, :description, :user, :image
  end

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true } # rubocop:disable Layout/LineLength

  with_options numericality: { other_than: 0 , message: "can't be blank" } do
    validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_duration_id
  end
end
