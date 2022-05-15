class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  has_many :item_warehouses
  has_many :warehouses, through: :item_warehouses
end
