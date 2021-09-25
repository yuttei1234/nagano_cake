class Public::ItemsController < ApplicationController

 def index
  @items = Item.page(params[:page]).per(8)
  @amount = Item.count
  @genres = Genre.all
 end

 def show
  @item = Item.find(params[:id])
  @cart_item = Cart_item.new
  @genres = Genre.all
 end

end