class Warehouse < ApplicationRecord
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :postal_code, presence: true

  has_many :item_warehouses
  has_many :items, through: :item_warehouses
end
