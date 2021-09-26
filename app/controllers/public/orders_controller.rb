class Public::OrdersController < ApplicationController

  def new
    @orders = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def create
    @orders = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    if @order.save
      @cart_items.each do |cart_item|
        @orders = Order.create(
        item_id: cart_item.item.id,
        order_id: @order.id,
        amount: cart_item.amount,
        price: cart_item.item.price)
      end
    # 新規住所登録時 (address登録コードを使用)
        @address = Address.create(
        customer_id: current_customer.id,
        name: params[:order][:name],
        postal_code: params[:order][:postal_code],
        address: params[:order][:address])
    # カート情報は登録後、削除
      current_customer.cart_items.destroy_all
    end
    redirect_to complete_public_orders_path
  end

  def show
    @orders= Order.find(params[:id])
  end

  def confirm
    @orders = Order.new(order_params)
    @orders.payment_method = params[:order][:payment_method]
    #運送先の選択
      if params[:address_select] == "1"
        @orders.postal_code = current_customer.postal_code
        @orders.address = current_customer.address
        @orders.name = current_customer.name
      elsif params[:address_select] == "2"
        @orders.postal_code = Address.find(params[:address_id]).postal_code
        @orders.address = Address.find(params[:address_id]).address
        @orders.name = Address.find(params[:address_id]).name
      end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end