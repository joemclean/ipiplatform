require 'test_helper'

class FormatTypesControllerTest < ActionController::TestCase
  setup do
    @format_type = format_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:format_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create format_type" do
    assert_difference('FormatType.count') do
      post :create, format_type: { name: @format_type.name }
    end

    assert_redirected_to format_type_path(assigns(:format_type))
  end

  test "should show format_type" do
    get :show, id: @format_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @format_type
    assert_response :success
  end

  test "should update format_type" do
    patch :update, id: @format_type, format_type: { name: @format_type.name }
    assert_redirected_to format_type_path(assigns(:format_type))
  end

  test "should destroy format_type" do
    assert_difference('FormatType.count', -1) do
      delete :destroy, id: @format_type
    end

    assert_redirected_to format_types_path
  end
end
