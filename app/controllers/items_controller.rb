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

  def new
  end

  def destroy
    ItemWarehouse.where(item_id: params[:id]).destroy_all
    Item.find(params[:id]).destroy

    redirect_to "/items"
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to "/items/#{@item.id}"
    else
      redirect_to "/items/new"
      flash[:alert] = "#{@item.errors.full_messages.to_sentence}"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
