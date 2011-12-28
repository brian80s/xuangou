require 'test_helper'

class FlagsControllerTest < ActionController::TestCase
  setup do
    @flag = flags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flag" do
    assert_difference('Flag.count') do
      post :create, flag: @flag.attributes
    end

    assert_redirected_to flag_path(assigns(:flag))
  end

  test "should show flag" do
    get :show, id: @flag.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flag.to_param
    assert_response :success
  end

  test "should update flag" do
    put :update, id: @flag.to_param, flag: @flag.attributes
    assert_redirected_to flag_path(assigns(:flag))
  end

  test "should destroy flag" do
    assert_difference('Flag.count', -1) do
      delete :destroy, id: @flag.to_param
    end

    assert_redirected_to flags_path
  end
end
