class LoginPage < Page
  PATH = '/sessions/new'

  def initialize(page)
    @page = page
  end

  def navigate
    @page.visit(PATH)
  end
end
