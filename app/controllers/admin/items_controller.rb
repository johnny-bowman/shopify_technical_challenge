class Admin::ItemsController < ApplicationController
  def index
    @warehouse = Warehouse.find(params[:id])
    @items = Item.order("name ASC")
  end
end
