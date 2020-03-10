class Item < ApplicationRecord
  has_many :carts

  has_many :order_items
  has_many :orders, through: :order_items

  has_many :cart_items
  has_many :carts, through: :cart_items

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
  validates :image_url, presence: true

  

end
