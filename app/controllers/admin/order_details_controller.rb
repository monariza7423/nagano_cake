class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if OrderDetail.where(product_status: 'status2', order_id: @order.id).count == 1
      @order.update(status: 'status2')
    elsif OrderDetail.where(product_status: 'status3', order_id: @order.id).count == @order.order_details.count
      @order.update(status: 'status3')
    end
    redirect_to admin_order_path(@order.id)
  end
  
  private
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :purchase_price, :amount, :product_status)
  end
end
