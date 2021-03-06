class Public::OrdersController < ApplicationController

  def new
    @orders = Order.new
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def create
    @orders = Order.new(order_params)
    @orders.customer_id = current_customer.id
    @cart_items = CartItem.where(customer_id: current_customer.id)
    if @orders.save
      @cart_items.each do |cart_item|
        @order_details= OrderDetail.new
        @order_details.item_id = cart_item.item.id
        @order_details.order_id = @orders.id
        @order_details.amount = cart_item.amount
        @order_details.price = cart_item.item.price
        @order_details.save
      end
    # 新規住所登録時 (address登録コードを使用)
        @address = Address.create(
        customer_id: current_customer.id,
        name: params[:order][:name],
        postal_code: params[:order][:postal_code],
        addresses: params[:order][:address])
    # カート情報は登録後、削除
      current_customer.cart_items.destroy_all
    end
    redirect_to complete_public_orders_path
  end

  def show
    @order= Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def confirm
    @orders = Order.new(order_params)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @orders.payment_method = params[:order][:payment_method]
    #運送先の選択
      if params[:order][:shippingaddress] == "1"
        @orders.postal_code = current_customer.postal_code
        @orders.address = current_customer.address
        @orders.name = current_customer.last_name + current_customer.first_name
      elsif params[:order][:shippingaddress] == "2"
        @orders.postal_code = Address.find(params[:order][:address_id]).postal_code
        @orders.address = Address.find(params[:order][:address_id]).addresses
        @orders.name = Address.find(params[:order][:address_id]).name
      else params[:order][:shippingaddress]
        @orders.postal_code = params[:order][:postal_code]
        @orders.address = params[:order][:address]
        @orders.name = params[:order][:name]
      end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end