class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_detail = @order.order_details
    if @order.status == 'status1'
      @order_detail.update_all(product_status: 'status1')
    end
    redirect_to admin_order_path(@order.id)
  end
  
  private
  def order_params
    params.require(:order).permit(:invoice_postalcode, :invoice_address, :pay_method, :invoice_name, :postage, :billing, :status)
  end
end
