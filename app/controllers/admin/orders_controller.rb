class Admin::OrdersController < ApplicationController

  def new
    @orders = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def create
    if @orders = Order.new(order)
    @cart_items = Cart_items.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        @orders = Order.create(
        item_id: cart_item.item.id,
        order_id: @order.id,
        amount: cart_item.amount,
        price: cart_item.item.price)
    end

    redirect_to complete_public_orders_path

    else
      render :confirm
    end
  end

  def show
    @orders= Order.find(params[:id])
  end

  def confirm
    @orders = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end

  def complete
  end

  private

  def order_params
    params.require(order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
