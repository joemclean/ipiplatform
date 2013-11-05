class IndustriesController < ApplicationController
  before_filter :redirect_if_unauthorized
  before_action :set_industry, only: [:show, :edit, :update, :destroy]

  def index
    @industries = Industry.all
  end

  def show
  end

  def new
    @industry = Industry.new
  end

  def edit
  end

  def create
    @industry = Industry.new(industry_params)

    respond_to do |format|
      if @industry.save
        format.html { redirect_to @industry, notice: 'Industry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @industry }
      else
        format.html { render action: 'new' }
        format.json { render json: @industry.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @industry.update(industry_params)
        format.html { redirect_to @industry, notice: 'Industry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @industry.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @industry.destroy
    respond_to do |format|
      format.html { redirect_to industries_url }
      format.json { head :no_content }
    end
  end

  private
    def set_industry
      @industry = Industry.find(params[:id])
    end

    def industry_params
      params.require(:industry).permit(:name)
    end
end
