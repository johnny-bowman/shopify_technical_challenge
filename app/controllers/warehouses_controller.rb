class WarehousesController < ApplicationController
  def index
    if params[:search]
      @warehouses = Warehouse.search_by_location(params[:search])
    else
      @warehouses = Warehouse.all
    end
  end

  def show
    @warehouse = Warehouse.find(params[:id])
  end

  def new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to "/warehouses/#{@warehouse.id}"
    else
      redirect_to "/warehouses/new"
      flash[:alert] = "#{@warehouse.errors.full_messages.to_sentence}"
    end
  end

  private

  def warehouse_params
    params.permit(:address, :city, :state, :country, :postal_code, :search)
  end
end
