require 'test_helper'

class CheersControllerTest < ActionController::TestCase
  setup do
    @cheer = cheers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cheers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cheer" do
    assert_difference('Cheer.count') do
      post :create, cheer: @cheer.attributes
    end

    assert_redirected_to cheer_path(assigns(:cheer))
  end

  test "should show cheer" do
    get :show, id: @cheer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cheer.to_param
    assert_response :success
  end

  test "should update cheer" do
    put :update, id: @cheer.to_param, cheer: @cheer.attributes
    assert_redirected_to cheer_path(assigns(:cheer))
  end

  test "should destroy cheer" do
    assert_difference('Cheer.count', -1) do
      delete :destroy, id: @cheer.to_param
    end

    assert_redirected_to cheers_path
  end
end
