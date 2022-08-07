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
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.save
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.order_id = @order.id
        order_detail.purcase_price = cart_item.subtotal
        order_detail.product_status = 0
        order_detail.save
      end
      redirect_to orders_complete_path
      cart_items.destroy_all
    else
      puts @order.errors.full_messages
      @order = Order.new(order_params)
      @address = current_customer.addresses
      render :new
    end
  end
  
  def complete
    
  end
  
  private
  def order_params
    params.require(:order).permit(:invoice_postalcode, :invoice_address, :pay_method, :invoice_name, :postage, :billing, :status)
  end
end
