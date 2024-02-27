class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end
  
  private
  
  def item_params
    params.require(:item).permit(:profile_image, :name, :introduction, :price)
  end
end
