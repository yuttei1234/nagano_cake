class Admin::OrderDetailsController < ApplicationController

  def update
    @orders= Order.find(params[:id])
    @orders.update(order_params)
    redirect_to admin_admin_orders_path
  end

  private

  def order_details_params
    params.require(:order_detail).permit(:making_status)
  end

end