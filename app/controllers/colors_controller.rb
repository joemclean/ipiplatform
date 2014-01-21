class ColorsController < ApplicationController
  before_filter :redirect_if_not_signed_in, except: [:show]

  before_filter :redirect_if_unauthorized, except: [:show]

  before_action :set_color, only: [:show, :edit, :update, :destroy]

  def index
    @colors = Color.all
  end

  def show
    @color = Color.find(params[:id])
  end

  def new
    @color = Color.new
    @value_propositions = ValueProposition.all
  end

  def edit
  end

  def create
    @color = Color.new(color_params)

    ActiveRecord::Base.transaction do
      @color.save
      @color.value_proposition_category = ValueProposition.find(params[:value_proposition_id])
      @color_saved = @color.save
    end

    if @color_saved
      respond_to do |format|
        format.html { redirect_to colors_path, notice: 'Color was successfully created.' }
        format.json { render action: 'show', status: :created, location: @color }
      end
    else
      respond_to do |format|
        @value_propositions = ValueProposition.all
        format.html { render action: 'new' }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @color.update(color_params)
      if params[:value_proposition_id].present?
        @color.value_proposition_category = ValueProposition.find(params[:value_proposition_id])
      else
        @color.value_proposition_category = nil
      end
      @color_saved = @color.save
    end

    if @color_saved
      respond_to do |format|
        format.html { redirect_to colors_path, notice: 'Color was successfully updated.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      format.html { redirect_to colors_path }
      format.json { head :no_content }
    end
  end

  private

  def set_color
    @color = Color.find(params[:id])
    @value_propositions = ValueProposition.all
  end

  def color_params
    params.require(:color).permit(:name, :description, :value_proposition_category, :image)
  end

end
