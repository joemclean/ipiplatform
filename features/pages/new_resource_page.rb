class NewResourcePage < Page
  def initialize(page, step_id)
    @page = page
    @step_id = step_id
  end

  def navigate
    @page.visit(path)
  end

  def path
    "/resources/new/#{@step_id}"
  end
end
