class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_items= Cart_item.where(customer_id: current_customer.id)
  end

  def create
    @cart_item= Cart_item.new(cart_item_params)
    @cart_item.customer_id= current_customer.id
    if @cart_item.save
      redirect_to public_cart_items_path
    else
      @cart_item= Cart_item.find(params[:id])
      render 'public/items/show'
    end
  end

  def update
    @cart_items= Cart_item.find(params[:id])
    if @cart_items.update(cart_item_params)
      redirect_to public_cart_item_path
    else
      render :index
    end
  end

  def destroy_all
    @customer= Customer.find(current_customer.id)
    if @customer.cart_items.destroy_all
      redirect_to public_cart_items_path
    else
      render :index
    end
  end

  def destroy
    @cart_items= Cart_item.find(params[:id])
    if cart_items.destroy
      redirect_to public_cart_items_path
    else
      redner :index
    end
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end