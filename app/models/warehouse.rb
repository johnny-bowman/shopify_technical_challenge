class Warehouse < ApplicationRecord
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true
  validates :postal_code, presence: true

  has_many :item_warehouses
  has_many :items, through: :item_warehouses

  def self.search_by_location(search_params)
    find_by_sql("SELECT * FROM warehouses WHERE address = '#{search_params}' OR city = '#{search_params}' OR state = '#{search_params}' OR country = '#{search_params}' OR postal_code = '#{search_params}'")
  end
end
