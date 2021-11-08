class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :shipping_area
  belongs_to :shipping_date
  belongs_to :user
  #has_one :order
  has_one_attached :image

  with_options presence: true do
    validates :item_name, :item_info
  end

  validates :price, presence: true, numericality: {with: /\A[0-9]+\z/, message: "Half-width number" }, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range"}

  with_options presence: true, numericality: { other_than: 1 , message: "can't be blank"} do
    validates :category_id, :condition_id, :shipping_cost_id, :shipping_area_id, :shipping_date_id
  end
end
