class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]

  before_filter :redirect_if_not_signed_in, except: [:show]

  before_filter :redirect_if_unauthorized, except: [:show]


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

    begin
      @color.save
      @color.value_proposition = ValueProposition.find(params[:value_proposition_id])
      @color.save

      respond_to do |format|
        format.html { redirect_to colors_path, notice: 'Color was successfully created.' }
        format.json { render action: 'show', status: :created, location: @color }
      end

    rescue
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    begin
      @color.update(color_params)
      @color.value_proposition = ValueProposition.find(params[:value_proposition_id])
      @color.save

      respond_to do |format|
        format.html { redirect_to edit_color_path, notice: 'Color was successfully updated.' }
        format.json { head :no_content }
      end

    rescue
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
    params.require(:color).permit(:name, :description, :value_proposition)
  end

end
