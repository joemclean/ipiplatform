class ValuePropositionsController < ApplicationController

  def show
    @value_propositions = ValueProposition.all
  end

  def update
    value_proposition = ValueProposition.find(params[:id])
    value_proposition.update_attributes(params[:value_proposition])
    params[:value_proposition][:colors_attributes].values.each do |color_params|
      Color.find(color_params[:id]).update_attributes(color_params)
    end

    redirect_to value_proposition_path
  end

end
