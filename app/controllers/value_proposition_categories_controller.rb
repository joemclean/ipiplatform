class ValuePropositionCategoriesController < ApplicationController
  before_filter :redirect_if_not_signed_in, except: [:show]

  before_filter :redirect_if_unauthorized, except: [:show]

  before_filter :set_value_proposition, except: [:show, :new, :create, :index]

  def new
    @value_proposition_category = ValuePropositionCategory.new
  end

  def create
    @value_proposition_category = ValuePropositionCategory.new(value_proposition_categories_params)

    respond_to do |format|
      if @value_proposition_category.save
        format.html { redirect_to @value_proposition_category, notice: 'Value proposition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @value_proposition_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @value_proposition_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @value_proposition_category.destroy
    respond_to do |format|
      format.html { redirect_to value_proposition_categories_path }
      format.json { head :no_content }
    end
  end

  def index
    @value_proposition_categories = ValuePropositionCategory.all
  end

  def show
    @value_proposition_category = ValuePropositionCategory.find(params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      @value_proposition_category.update_attributes(value_proposition_categories_params)

      if params[:value_proposition_category][:colors_attributes].present?
        params[:value_proposition_category][:colors_attributes].values.each do |color_params|
          Color.find(color_params[:id]).update(color_params)
        end
      end

    end
    redirect_to value_proposition_category_path
  end


  private
  def set_value_proposition
   @value_proposition_category = ValuePropositionCategory.find(params[:id])
  end

  def value_proposition_categories_params
    params.require(:value_proposition_category).permit(:name, :description, :color)
  end
end
