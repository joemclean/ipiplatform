require 'test_helper'

class IndustriesControllerTest < ActionController::TestCase
  setup do
    @industry = industries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:industries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create industry" do
    assert_difference('Industry.count') do
      post :create, industry: { name: @industry.name }
    end

    assert_redirected_to industry_path(assigns(:industry))
  end

  test "should show industry" do
    get :show, id: @industry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @industry
    assert_response :success
  end

  test "should update industry" do
    patch :update, id: @industry, industry: { name: @industry.name }
    assert_redirected_to industry_path(assigns(:industry))
  end

  test "should destroy industry" do
    assert_difference('Industry.count', -1) do
      delete :destroy, id: @industry
    end

    assert_redirected_to industries_path
  end
end
