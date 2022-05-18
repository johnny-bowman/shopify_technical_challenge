class Warehouse < ApplicationRecord
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :postal_code, presence: true

  has_many :item_warehouses
  has_many :items, through: :item_warehouses

  def self.search_by_location(search_params)
    find_by_sql("SELECT * FROM warehouses WHERE LOWER(address) = '#{search_params.downcase}' OR LOWER(city) = '#{search_params.downcase}' OR LOWER(state) = '#{search_params.downcase}' OR LOWER(country) = '#{search_params.downcase}' OR LOWER(postal_code) = '#{search_params.downcase}'")
  end

  def item_quantity(item_id)
    ItemWarehouse.where(item_id: item_id, warehouse_id: self.id).first.quantity
  end
end
