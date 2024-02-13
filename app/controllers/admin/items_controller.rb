class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end

  def create
    item = Item.new(item_params)
    item.save!
    redirect_to admin_item_path(item.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:profile_image, :name, :introduction, :price)
  end
end
