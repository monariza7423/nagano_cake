class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if CartItem.find_by(item_id: params[:cart_item][:item_id])
      @same_cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      @same_cart_item.amount += params[:cart_item][:amount].to_i
      @same_cart_item.update(amount: @same_cart_item.amount)
      redirect_to items_path
    else
      @cart_item.save
      redirect_to items_path
    end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to items_path
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to items_path
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
