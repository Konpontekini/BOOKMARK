class ItemsController < ApplicationController
  before_action :find_item, only: [:update, :edit, :show, :destroy, :category]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.save
    redirect_to items_path
  end

  def edit
  end

  def purchased
    @item.purchased? == true
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
      # recirect_to items_path
    else
      render :index
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:category_id, :item_url)
  end
end
