class ValuePropositionsController < ApplicationController
  before_filter :redirect_if_not_signed_in, except: [:show]

  before_filter :redirect_if_unauthorized, except: [:show]

  before_filter :set_value_proposition, except: [:show, :new, :create]

  def new
    @value_proposition = ValueProposition.new
  end

  def create
    @value_proposition = ValueProposition.new(value_propositions_params)

    respond_to do |format|
      if @value_proposition.save
        format.html { redirect_to @value_proposition, notice: 'Value proposition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @value_proposition }
      else
        format.html { render action: 'new' }
        format.json { render json: @value_proposition.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @value_propositions = ValueProposition.all
  end

  def update
    @value_proposition.update_attributes(value_propositions_params)
    params[:value_proposition][:colors_attributes].values.each do |color_params|
      Color.find(color_params[:id]).update(color_params)
    end

    redirect_to value_proposition_path
  end

  def destroy
    @value_proposition.destroy
    respond_to do |format|
      format.html { redirect_to value_proposition_path }
      format.json { head :no_content }
    end
  end


  private
  def set_value_proposition
   @value_proposition = ValueProposition.find(params[:id])
  end

  def value_propositions_params
    params.require(:value_proposition).permit(:name, :description, :color)
  end
end
