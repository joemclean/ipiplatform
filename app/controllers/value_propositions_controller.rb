class ValuePropositionsController < ApplicationController
  before_filter :redirect_if_not_signed_in, except: [:show]

  before_filter :redirect_if_unauthorized, except: [:show]

  before_action :set_value_proposition, only: [:show, :edit, :update, :destroy]

  def index
    @value_proposition = ValueProposition.all
  end

  def show
    @value_proposition = ValueProposition.find(params[:id])
  end

  def new
    @value_proposition = ValueProposition.new
    @value_proposition_categories = ValuePropositionCategory.all
  end

  def edit
    @steps = ValueProposition.find(params[:id]).steps
  end

  def create
    @value_proposition = ValueProposition.new(value_proposition_params)

    ActiveRecord::Base.transaction do
      @value_proposition.save
      @value_proposition.value_proposition_category = ValuePropositionCategory.find(params[:value_proposition_category_id])
      @value_proposition_saved = @value_proposition.save
    end

    if @value_proposition_saved
      respond_to do |format|
        format.html { redirect_to value_propositions_path, notice: 'Value proposition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @value_proposition }
      end
    else
      respond_to do |format|
        @value_proposition_categories = ValuePropositionCategory.all
        format.html { render action: 'new' }
        format.json { render json: @value_proposition.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @value_proposition.update(value_proposition_params)
      if params[:value_proposition_category_id].present?
        @value_proposition.value_proposition_category = ValuePropositionCategory.find(params[:value_proposition_category_id])
      else
        @value_proposition.value_proposition_category = nil
      end
      @value_proposition_saved = @value_proposition.save
    end

    if @value_proposition_saved
      respond_to do |format|
        format.html { redirect_to value_propositions_path, notice: 'Value proposition was successfully updated.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @value_proposition.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @value_proposition.destroy
    respond_to do |format|
      format.html { redirect_to value_propositions_path }
      format.json { head :no_content }
    end
  end

  private

  def set_value_proposition
    @value_proposition = ValueProposition.find(params[:id])
    @value_proposition_categories = ValuePropositionCategory.all
  end

  def value_proposition_params
    params.require(:value_proposition).permit(:name, :description, :value_proposition_category, :image)
  end

end
