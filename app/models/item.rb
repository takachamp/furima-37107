class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :shipping_area
  belongs_to :shipping_date
  belongs_to :user
  has_one :order
  has_one_attached :image

  with_options presence: true do
    validates :image, :item_name, :item_info
  end

  validates :price, presence: true, numericality: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id, :condition_id, :shipping_cost_id, :shipping_area_id, :shipping_date_id
  end
end
