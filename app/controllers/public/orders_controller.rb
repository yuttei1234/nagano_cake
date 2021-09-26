class Public::OrdersController < ApplicationController

  def new
    @orders = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def create
    if @orders = Order.new(order)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    
      @cart_items.each do |cart_item|
        @orders = Order.create(
        item_id: cart_item.item.id,
        order_id: @order.id,
        amount: cart_item.amount,
        price: cart_item.item.price)
      end
    # 新規住所登録 (address登録コードを使用)
        @address = Address.create(
        customer_id: current_customer.id,
        name: params[:order][:name],
        postal_code: params[:order][:postal_code],
        address: params[:order][:address])

    # カート情報は登録後、削除
    cart_items.destroy_all
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

    #支払方法の選択
      if params[:payment_select] == "0"
        session[:customer] [:payment_method] = 0
      elsif params[:payment_select] == "1"
        session[:customer] [:payment_method] = 1
      end
    
    #運送先の選択
      if params[:address_select] == "1"
        session[:customer] [:postal_code] = current_customer.postal_code
        session[:customer] [:address] = current_customer.address
        session[:customer] [:name] = current_customer.name
      elsif params[:address_select] == "2"
        session[:customer] [:postal_code] = Address.find(params[:address_id]).postal_code
        session[:customer] [:address] = Address.find(params[:address_id]).address
        session[:customer] [:name] = Address.find(params[:address_id]).name
      else 
        session[:customer] [:postal_code] = Address.new(@orders).postal_code
        session[:customer] [:address] = Address.new(@orders).address
        session[:customer] [:name] = Address.new().name
      end
      redirect_to complete_public_orders_path      
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end