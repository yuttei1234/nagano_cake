class Admin::OrderDetailsController < ApplicationController

  def update
    @order_details= OrderDetail.find(params[:id])
    @order_details.update(order_detail_params)
    redirect_to admin_admin_orders_path
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end