class Public::CustomersController < ApplicationController

 before_action :authenticate_customer!, except: :top

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_customer_path(@customer.id), notice:"登録情報を変更しました"
    else
      render "customers/edit"
    end
  end

  def unsubscribe
    @customer = current_customer
    #binding.pry
  end

  def withdraw
    @customer = current_customer
    #binding.pry
    @customer.update(validation: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :fisrt_name, :kata_last_name, :kata_fisrt_name, :email, :postal_code, :address, :telephone_number)
  end

end