module ValuePropositionsHelper
  def value_proposition_for_select
    ValueProposition.where(:all, :order => 'name').collect {|f| [ f.name, f.id ] }
  end
end
