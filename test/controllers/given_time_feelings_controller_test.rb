require 'test_helper'

class GivenTimeFeelingsControllerTest < ActionController::TestCase
  setup do
    @given_time_feeling = given_time_feelings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:given_time_feelings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create given_time_feeling" do
    assert_difference('GivenTimeFeeling.count') do
      post :create, given_time_feeling: { feeling_id: @given_time_feeling.feeling_id, situation_id: @given_time_feeling.situation_id }
    end

    assert_redirected_to given_time_feeling_path(assigns(:given_time_feeling))
  end

  test "should show given_time_feeling" do
    get :show, id: @given_time_feeling
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @given_time_feeling
    assert_response :success
  end

  test "should update given_time_feeling" do
    patch :update, id: @given_time_feeling, given_time_feeling: { feeling_id: @given_time_feeling.feeling_id, situation_id: @given_time_feeling.situation_id }
    assert_redirected_to given_time_feeling_path(assigns(:given_time_feeling))
  end

  test "should destroy given_time_feeling" do
    assert_difference('GivenTimeFeeling.count', -1) do
      delete :destroy, id: @given_time_feeling
    end

    assert_redirected_to given_time_feelings_path
  end
end
