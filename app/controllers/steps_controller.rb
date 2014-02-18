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
    @value_proposition_id = @step.value_proposition_id
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
    if @step.update(step_params)
      redirect_to edit_value_proposition_path(step_params[:value_proposition_id]), notice: 'Step was successfully updated.'
    else
      @resources = @step.resources
      render action: 'edit'
    end
  end

  def destroy
    @step.destroy
    redirect_to edit_value_proposition_path(@step.value_proposition_id)
  end

  def reorder
    params.require(:value_proposition_id)
    @steps = ValueProposition.find(params[:value_proposition_id]).steps
    @value_proposition_id = params[:value_proposition_id]
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
