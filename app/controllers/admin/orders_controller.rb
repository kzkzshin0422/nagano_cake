class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @total = @order.orderdetails.inject(0) { |subtotal, orderdetail| subtotal + orderdetail.subtotal }
  end
  
end
