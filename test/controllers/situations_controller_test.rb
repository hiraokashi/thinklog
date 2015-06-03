require 'test_helper'

class SituationsControllerTest < ActionController::TestCase
  setup do
    @situation = situations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:situations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create situation" do
    assert_difference('Situation.count') do
      post :create, situation: { user_id: @situation.user_id, what_have_you_been_doing: @situation.what_have_you_been_doing, when: @situation.when, where: @situation.where, with_whom: @situation.with_whom }
    end

    assert_redirected_to situation_path(assigns(:situation))
  end

  test "should show situation" do
    get :show, id: @situation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @situation
    assert_response :success
  end

  test "should update situation" do
    patch :update, id: @situation, situation: { user_id: @situation.user_id, what_have_you_been_doing: @situation.what_have_you_been_doing, when: @situation.when, where: @situation.where, with_whom: @situation.with_whom }
    assert_redirected_to situation_path(assigns(:situation))
  end

  test "should destroy situation" do
    assert_difference('Situation.count', -1) do
      delete :destroy, id: @situation
    end

    assert_redirected_to situations_path
  end
end
