require 'test_helper'

class AutomaticThoughtsControllerTest < ActionController::TestCase
  setup do
    @automatic_thought = automatic_thoughts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:automatic_thoughts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create automatic_thought" do
    assert_difference('AutomaticThought.count') do
      post :create, automatic_thought: { contents: @automatic_thought.contents, given_time_feeling_id: @automatic_thought.given_time_feeling_id }
    end

    assert_redirected_to automatic_thought_path(assigns(:automatic_thought))
  end

  test "should show automatic_thought" do
    get :show, id: @automatic_thought
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @automatic_thought
    assert_response :success
  end

  test "should update automatic_thought" do
    patch :update, id: @automatic_thought, automatic_thought: { contents: @automatic_thought.contents, given_time_feeling_id: @automatic_thought.given_time_feeling_id }
    assert_redirected_to automatic_thought_path(assigns(:automatic_thought))
  end

  test "should destroy automatic_thought" do
    assert_difference('AutomaticThought.count', -1) do
      delete :destroy, id: @automatic_thought
    end

    assert_redirected_to automatic_thoughts_path
  end
end
