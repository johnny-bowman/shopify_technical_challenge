class Admin::ItemWarehousesController < ApplicationController
  def create
    if ItemWarehouse.where(search_params).empty?
      ItemWarehouse.create(item_id: params[:item_id], warehouse_id: params[:warehouse_id], quantity: params[:quantity].to_i)
    else
      iw = ItemWarehouse.where(search_params).first
      iw.update(quantity: params[:quantity].to_i + iw.quantity)
    end

    redirect_to "/warehouses/#{params[:warehouse_id]}"
  end

  private

  def search_params
    params.permit(:item_id, :warehouse_id)
  end
end
