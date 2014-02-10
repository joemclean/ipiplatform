class ResourcePage < Page

  def initialize(page)
    super page
  end

  def navigate
    @page.visit(path)
  end

  def navigate_to_show_page resource_id
    @page.visit("#{self.path}/#{resource_id}")
  end

  def path
    '/resources'
  end
end
