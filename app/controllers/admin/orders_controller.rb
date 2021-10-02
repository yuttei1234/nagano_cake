class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all
    @order_details = OrderDetail.all
  end

  def show
    @order= Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    @orders= Order.find(params[:id])
    @orders.update(order_params)
    redirect_to admin_admin_orders_path
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
