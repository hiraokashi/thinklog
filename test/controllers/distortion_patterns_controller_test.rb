require 'test_helper'

class DistortionPatternsControllerTest < ActionController::TestCase
  setup do
    @distortion_pattern = distortion_patterns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:distortion_patterns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distortion_pattern" do
    assert_difference('DistortionPattern.count') do
      post :create, distortion_pattern: { cognitive_distortion_id: @distortion_pattern.cognitive_distortion_id, distortion_pattern: @distortion_pattern.distortion_pattern }
    end

    assert_redirected_to distortion_pattern_path(assigns(:distortion_pattern))
  end

  test "should show distortion_pattern" do
    get :show, id: @distortion_pattern
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @distortion_pattern
    assert_response :success
  end

  test "should update distortion_pattern" do
    patch :update, id: @distortion_pattern, distortion_pattern: { cognitive_distortion_id: @distortion_pattern.cognitive_distortion_id, distortion_pattern: @distortion_pattern.distortion_pattern }
    assert_redirected_to distortion_pattern_path(assigns(:distortion_pattern))
  end

  test "should destroy distortion_pattern" do
    assert_difference('DistortionPattern.count', -1) do
      delete :destroy, id: @distortion_pattern
    end

    assert_redirected_to distortion_patterns_path
  end
end
