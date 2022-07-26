class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @items = Item.all
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
