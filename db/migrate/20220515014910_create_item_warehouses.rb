class CreateItemWarehouses < ActiveRecord::Migration[5.2]
  def change
    create_table :item_warehouses do |t|
      t.references :item, foreign_key: true
      t.references :warehouse, foreign_key: true
    end
  end
end
