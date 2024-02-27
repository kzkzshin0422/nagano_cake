class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
   @order = Order.new(order_params)

         if params[:order][:address_option] == "0"
         @order.postal_code = current_customer.postal_code
         @order.address = current_customer.address
         @order.name = current_customer.last_name + current_customer.first_name

         elsif params[:order][:address_option] == "1"
         @order.postal_code = params[:order][:postal_code]
         @order.address = params[:order][:address]
         @order.name = params[:order][:name]
         else
             render 'new'
         end
   @cart_items = current_customer.cart_items.all
   @order.postage = 800
  end

  def create
        @order = Order.new(order_params)
        @order.customer_id = current_customer.id
        if @order.save

            current_customer.cart_items.each do |cart_item| 
            @orderdetail = Orderdetail.new 
            @orderdetail.order_id = @order.id 
            @orderdetail.item_id = cart_item.item_id 
            @orderdetail.amount = cart_item.amount 
            @orderdetail.price = cart_item.item.with_tax_price
            @orderdetail.save
            end
            current_customer.cart_items.destroy_all
        end
        redirect_to orders_complete_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @total = @order.orderdetails.inject(0) { |subtotal, orderdetail| subtotal + orderdetail.subtotal }
  end

  private

    def order_params
        params.require(:order).permit(:postage, :payment_method, :customer_id, :postal_code, :address, :name, :total_payment)
    end
end
