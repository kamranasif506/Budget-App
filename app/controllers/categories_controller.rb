class CategoriesController < ApplicationController
    def index
      user = current_user.id
      @categories = Category.includes(:author)
    end
    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      @category.author = current_user
      if @category.save
        # Handle successful category creation
        redirect_to categories_path, notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    private
    def category_params
      params.require(:category).permit(:name, :icon)
    end
end
  