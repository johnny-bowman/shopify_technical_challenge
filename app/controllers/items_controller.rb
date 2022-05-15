class ItemsController < ApplicationController
  def index
    @items = Item.order("name ASC")
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end
end
