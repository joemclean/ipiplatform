class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy]

  def index
    @steps = Step.all
  end

  def show
  end

  def new
    @step = Step.new
    @value_proposition_id = params[:value_proposition_id]
  end

  def new_resource
   @resource = Resource.new
   @step_id = params[:step_id]
  end

  def create_resource

  end

  def edit
      @resources = @step.resources
  end

  def create
    @step = Step.new(step_params)

    if @step.save
      redirect_to edit_value_proposition_url(step_params[:value_proposition_id]), notice: 'Step was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'Step was successfully updated.' }
        format.json { head :no_content }
      else
        @resources = @step.resources
        format.html { render action: 'edit' }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to steps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step
      @step = Step.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:name, :description, :value_proposition_id)
    end
end
