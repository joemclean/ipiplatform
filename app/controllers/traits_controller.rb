class TraitsController < ApplicationController
  before_action :set_trait, only: [:show, :edit, :update, :destroy]
  
  before_filter :authorized?, except: [:index, :show]

  before_filter :signed_in?


  def index
    @traits = Trait.all
  end

  def show
  end

  def new
    @trait = Trait.new
  end

  def edit
  end

  def create
    @trait = Trait.new(trait_params)

    respond_to do |format|
      if @trait.save
        format.html { redirect_to @trait, notice: 'Trait was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trait }
      else
        format.html { render action: 'new' }
        format.json { render json: @trait.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trait.update(trait_params)
        format.html { redirect_to @trait, notice: 'Trait was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trait.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trait.destroy
    respond_to do |format|
      format.html { redirect_to traits_url }
      format.json { head :no_content }
    end
  end

  private
  
    def set_trait
      @trait = Trait.find(params[:id])
    end

    def trait_params
      params.require(:trait).permit(:name, :description, :full_trait_description, :spectrum_id)
    end

end
