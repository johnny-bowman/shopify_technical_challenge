class ItemsController < ApplicationController
  def index
    if params[:search]
      @items = Item.search_by_name(params[:search])
    else
      @items = Item.order("name ASC")
    end
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

      flash[:error] = @item.errors.full_messages
    end
  end

  def new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to "/items/#{@item.id}"
    else
      redirect_to "/items/new"
      flash[:error] = @item.errors.full_messages
    end
  end

  def destroy
    ItemWarehouse.where(item_id: params[:id]).destroy_all
    Item.find(params[:id]).destroy

    redirect_to "/items"
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
