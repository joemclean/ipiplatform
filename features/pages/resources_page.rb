class Resources < Page

  def initialize(page)
    super page
  end

  def navigate
    @page.visit(path)
  end

  def navigate_to_show_page resource_id
    @page.visit("resources/#{resource_id}")
  end

  def path
    'resources'
  end
end