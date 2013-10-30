module ColorsHelper
  def colors_for_select
    Color.where(:all, :order => 'name').collect {|f| [ f.name, f.id ] }
  end
end
