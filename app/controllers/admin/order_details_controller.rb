class Admin::OrderDetailsController < ApplicationController

  def update
    
    
  end
  
  private

  def order_details_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end

end