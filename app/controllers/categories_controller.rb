class CategoriesController < ApplicationController
  # before_action :find_category, only: [:update, :edit, :destroy]

  def index
    @categories = Category.all
    raise
  end

  # def new
  #   @category = Category.new
  # end

  # def create
  #   @category = Category.new(category_params)
  #   @category.save
  #   redirect_to items_path
  # end

  # def edit
  # end

  # def update
  #   if @category.update(category_params)
  #     redirect_to categories_path
  #   else
  #     render :index
  #   end
  # end

  # def destroy
  #   @category.destroy
  #   redirect_to items_path
  # end


  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
