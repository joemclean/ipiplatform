class ValuePropositionsController < ApplicationController
  before_filter :redirect_if_not_signed_in, except: [:show]

  before_filter :redirect_if_unauthorized, except: [:show]

  def show
    @value_propositions = ValueProposition.all
  end

  def update
    value_proposition = ValueProposition.find(params[:id])
    value_proposition.update_attributes(params[:value_proposition])
    params[:value_proposition][:colors_attributes].values.each do |color_params|
      Color.find(color_params[:id]).update(color_params)
    end

    redirect_to value_proposition_path
  end

end
