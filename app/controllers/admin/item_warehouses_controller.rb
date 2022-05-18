class Admin::ItemWarehousesController < ApplicationController
  def create
    params[:quantity].to_i.times { ItemWarehouse.create(item_id: params[:item_id], warehouse_id: params[:warehouse_id]) }

    redirect_to "/warehouses/#{params[:warehouse_id]}"
  end
end
