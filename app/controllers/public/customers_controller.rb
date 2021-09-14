class Public::CustomersController < ApplicationController
  
  before_action :authenticate_customer!, except: :top
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path, notice:"登録情報を変更しました"
    else
      render :edit
    end   
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :fisrt_name, :kata_last_name, :kata_fisrt_name, :email, :postal_code, :address, :telephone_number)
  end
  
end
