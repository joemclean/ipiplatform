class HomePage < Page
  def initialize(page)
    @page = page
  end

  def navigate
    @page.visit(path)
  end

  def path
    '/'
  end
end
