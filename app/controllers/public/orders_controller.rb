class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = current_customer.addresses
  end
  
  def confirm
    @cart_items = current_customer.cart_items.all
    @total = 0
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.pay_method = params[:order][:payment_method]
    @order.postage = 800
    if params[:order][:address_number] == "0"
      @order.invoice_name = current_customer.last_name+current_customer.first_name
      @order.invoice_postalcode = current_customer.postal_code
      @order.invoice_address = current_customer.address
    elsif params[:order][:address_number] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.invoice_name = @address.name
      @order.invoice_postalcode = @address.postal_code
      @order.invoice_address = @address.address
    elsif params[:order][:address_number] == "2"
      @order.invoice_name = params[:order][:invoice_name]
      @order.invoice_postalcode = params[:order][:invoice_postalcode]
      @order.invoice_address = params[:order][:invoice_address]
    end
    render :confirm
  end
  
  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to orders_confirm_path
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :invoice_postalcode, :invoice_address, :pay_method, :invoice_name, :postage, :billing, :status)
  end
end
