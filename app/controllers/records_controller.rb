class RecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find_by(id: params[:category_id], author: current_user)
    if @category
      @records = @category.records.order(created_at: :desc)
      @total_amount = @records.sum(:amount)
    else
      redirect_to categories_path, alert: "Category not found or doesn't belong to you."
    end
  end

  def new
    @category = Category.find(params[:category_id])
    @categories = Category.where(author_id: current_user.id).to_a
    @record = Record.new
  end

  def create
    p params
    @category = Category.find(params[:record][:category]) # Assuming you set @category in this action.
    @record = @category.records.new(record_params)
    @record.author = current_user

    if @record.save
      RecordItem.create(record: @record, category_id: params[:record][:category])
      redirect_to category_records_path(@category), notice: 'Record was successfully created.'
    else
      render :new
    end
  end

  private

  def record_params
    params.require(:record).permit(:name, :amount)
  end
end
