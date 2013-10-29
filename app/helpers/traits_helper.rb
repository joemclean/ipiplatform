module TraitsHelper
  def traits_for_select
    Trait.where(:all, :order => 'name').collect {|f| [ f.name, f.id ] }
  end
end
