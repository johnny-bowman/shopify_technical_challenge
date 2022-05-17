class WarehousesController < ApplicationController
  def index
    if params[:search]
      @warehouses = Warehouse.search_by_location(params[:search])
    else
      @warehouses = Warehouse.all
    end
  end

  private

  def warehouse_params
    params.permit(:address, :city, :state, :country, :postal_code, :search)
  end
end
