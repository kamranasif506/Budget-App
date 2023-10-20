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
    @categories = Category.where(author_id: current_user.id).to_a
    @category = Category.find_by(id: params[:category_id]) # Find by id to handle nil case
    @record = Record.new
  end

  def create
    if params[:record][:category].empty?
      redirect_to new_category_record_path(params[:category_id]), alert: 'Category is Required.'
    elsif params[:record][:name].empty? || params[:record][:amount].empty?
      redirect_to new_category_record_path(params[:category_id]), alert: 'All fields are required.'
    else
      @category = Category.find(params[:record][:category]) # Assuming you set @category in this action.
      if @category.nil?
        redirect_to new_category_record_path(params[:category_id]), alert: 'Category Not Found.'
      else
        @record = @category.records.new(record_params)
        @record.author = current_user
        
        respond_to do |format|
          if @record.save
            RecordItem.create!(record: @record, category_id: @category.id) # Use @category.id
            format.html { redirect_to category_records_path(@category), notice: 'Record was successfully created.' }
          else
            redirect_to new_category_record_path(params[:category_id]), alert: 'All parameter are required.'
          end
        end
      end
    end
    
    
  end

  private

  def record_params
    params.require(:record).permit(:name, :amount)
  end
end
