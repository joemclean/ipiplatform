require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get publisher" do
    get :publisher
    assert_response :success
  end

  test "should get innovator" do
    get :innovator
    assert_response :success
  end

end
