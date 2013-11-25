class UserProfilePage < Page
  def initialize(page, user_id)
    @page = page
    @user_id = user_id
  end

  def navigate
    @page.visit(path)
  end

  def path
    "/users/#{@user_id}"
  end
end
