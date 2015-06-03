require 'test_helper'

class AdaptiveThoughtsControllerTest < ActionController::TestCase
  setup do
    @adaptive_thought = adaptive_thoughts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adaptive_thoughts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adaptive_thought" do
    assert_difference('AdaptiveThought.count') do
      post :create, adaptive_thought: { automatic_thought_id: @adaptive_thought.automatic_thought_id, contents: @adaptive_thought.contents }
    end

    assert_redirected_to adaptive_thought_path(assigns(:adaptive_thought))
  end

  test "should show adaptive_thought" do
    get :show, id: @adaptive_thought
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adaptive_thought
    assert_response :success
  end

  test "should update adaptive_thought" do
    patch :update, id: @adaptive_thought, adaptive_thought: { automatic_thought_id: @adaptive_thought.automatic_thought_id, contents: @adaptive_thought.contents }
    assert_redirected_to adaptive_thought_path(assigns(:adaptive_thought))
  end

  test "should destroy adaptive_thought" do
    assert_difference('AdaptiveThought.count', -1) do
      delete :destroy, id: @adaptive_thought
    end

    assert_redirected_to adaptive_thoughts_path
  end
end
