class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = current_user.id
    @categories = Category.where(author_id: user)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.author = current_user
    if @category.save
      redirect_to category_records_path(@category), notice: 'Category was successfully created.'
    else
      redirect_to new_category_path, alert: 'All fileds are required.'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
