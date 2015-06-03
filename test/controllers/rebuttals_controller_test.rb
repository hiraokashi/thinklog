require 'test_helper'

class RebuttalsControllerTest < ActionController::TestCase
  setup do
    @rebuttal = rebuttals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rebuttals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rebuttal" do
    assert_difference('Rebuttal.count') do
      post :create, rebuttal: { automatic_thought_id: @rebuttal.automatic_thought_id, contents: @rebuttal.contents }
    end

    assert_redirected_to rebuttal_path(assigns(:rebuttal))
  end

  test "should show rebuttal" do
    get :show, id: @rebuttal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rebuttal
    assert_response :success
  end

  test "should update rebuttal" do
    patch :update, id: @rebuttal, rebuttal: { automatic_thought_id: @rebuttal.automatic_thought_id, contents: @rebuttal.contents }
    assert_redirected_to rebuttal_path(assigns(:rebuttal))
  end

  test "should destroy rebuttal" do
    assert_difference('Rebuttal.count', -1) do
      delete :destroy, id: @rebuttal
    end

    assert_redirected_to rebuttals_path
  end
end
