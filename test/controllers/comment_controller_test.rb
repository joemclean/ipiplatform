require 'test_helper'

class CommentControllerTest < ActionController::TestCase
  test "should get save_comment" do
    get :save_comment
    assert_response :success
  end

  test "should get delete_comment" do
    get :delete_comment
    assert_response :success
  end

  test "should get edit_comment" do
    get :edit_comment
    assert_response :success
  end

end
