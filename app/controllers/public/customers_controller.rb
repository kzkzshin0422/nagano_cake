class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  
  def update
    customer = current_customer
    customer.update(customer_params)
    redirect_to public_customer_path
  end
  
  def confirm
  end
  
  def withdrawal
    customer = current_customer
    customer.update(is_valid: false)
    reset_session
    redirect_to root_path
  end
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
  end
end
