class CategoriesController < ApplicationController
  before_action :find_category, only: [:update, :edit, :destroy]  
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to items_path
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path #question about path --- if change category and url of item at the same time?
      # redirect_to category_path(@category) 
    else
      render :index
    end
  end

  def destroy
    @category.destroy
    redirect_to items_path #question about path --- want to direct to items index page
  end


  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
