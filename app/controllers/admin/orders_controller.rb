class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
  
  def update
  end
  
  private
  def order_params
    params.require(:order).permit(:invoice_postalcode, :invoice_address, :pay_method, :invoice_name, :postage, :billing, :status)
  end
end
