# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected
  
  def reject_user
    @customer = Customer.find_by(name: params[:customer][:last_name][:first_name])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == false)
        redirect_to new_customer_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
  

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
