class FormatTypesController < ApplicationController
  before_filter :authorized?
  before_action :set_format_type, only: [:show, :edit, :update, :destroy]

  # GET /format_types
  # GET /format_types.json
  def index
    @format_types = FormatType.all
  end

  # GET /format_types/1
  # GET /format_types/1.json
  def show
  end

  # GET /format_types/new
  def new
    @format_type = FormatType.new
  end

  # GET /format_types/1/edit
  def edit
  end

  # POST /format_types
  # POST /format_types.json
  def create
    @format_type = FormatType.new(format_type_params)

    respond_to do |format|
      if @format_type.save
        format.html { redirect_to @format_type, notice: 'Format type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @format_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @format_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /format_types/1
  # PATCH/PUT /format_types/1.json
  def update
    respond_to do |format|
      if @format_type.update(format_type_params)
        format.html { redirect_to @format_type, notice: 'Format type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @format_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /format_types/1
  # DELETE /format_types/1.json
  def destroy
    @format_type.destroy
    respond_to do |format|
      format.html { redirect_to format_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_format_type
      @format_type = FormatType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def format_type_params
      params.require(:format_type).permit(:name)
    end
end
