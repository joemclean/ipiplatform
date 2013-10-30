class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]
  
  before_filter :authorized?, except: [:index, :show]

  before_filter :signed_in?


  def index
    @colors = Color.all
  end

  def show
  end

  def new
    @color = Color.new
  end

  def edit
  end

  def create
    @color = Color.new(color_params)

    respond_to do |format|
      if @color.save
        format.html { redirect_to @color, notice: 'Color was successfully created.' }
        format.json { render action: 'show', status: :created, location: @color }
      else
        format.html { render action: 'new' }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to @color, notice: 'Color was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      format.html { redirect_to colors_url }
      format.json { head :no_content }
    end
  end

  private
  
    def set_color
      @color = Color.find(params[:id])
    end

    def color_params
      params.require(:color).permit(:name, :description, :value_proposition.id)
    end

end
