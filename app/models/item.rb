class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  has_many :item_warehouses
  has_many :warehouses, through: :item_warehouses

  def self.search_by_name(search_params)
    where("LOWER(name) = ?", "#{search_params.downcase}")
  end
end
