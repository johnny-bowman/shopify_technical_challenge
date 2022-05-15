class ItemsController < ApplicationController
  def index
    @items = Item.order("name ASC")
  end
end
