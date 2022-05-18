class AddQuantityToItemWarehouses < ActiveRecord::Migration[5.2]
  def change
    add_column :item_warehouses, :quantity, :integer, default: 0
  end
end
