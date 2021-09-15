class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!

  def index
    @address = Address.new
    @address = Address.find(params[:id])
  end

  def edit
    @address = Address.find(params[:id])
  end

  def creates
    @address = Address.new(address_params)
    @address.customer = current_customer.id
    if @address.save
      redirect_to public_addresses_path
    else
      @addresses = Address.where(customer_id: currnet_customer.id)
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.save(address_params)
      redirect_to public_addresses_path(@address.id)
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path
  end

  def private
    params.require(:address).permit(:postal_code, :address, :addressee)
  end

end