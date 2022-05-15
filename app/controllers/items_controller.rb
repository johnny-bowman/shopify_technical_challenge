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

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    @item.save

    if @item.save
      redirect_to "/items/#{@item.id}", alert: "#{@item.name} has been updated"
    else
      redirect_to "/items/#{@item.id}/edit"
      flash[:alert] = "Error: #{error_message(@item.errors)}"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
