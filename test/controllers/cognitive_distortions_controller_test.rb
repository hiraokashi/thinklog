require 'test_helper'

class CognitiveDistortionsControllerTest < ActionController::TestCase
  setup do
    @cognitive_distortion = cognitive_distortions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cognitive_distortions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cognitive_distortion" do
    assert_difference('CognitiveDistortion.count') do
      post :create, cognitive_distortion: { name: @cognitive_distortion.name, question: @cognitive_distortion.question }
    end

    assert_redirected_to cognitive_distortion_path(assigns(:cognitive_distortion))
  end

  test "should show cognitive_distortion" do
    get :show, id: @cognitive_distortion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cognitive_distortion
    assert_response :success
  end

  test "should update cognitive_distortion" do
    patch :update, id: @cognitive_distortion, cognitive_distortion: { name: @cognitive_distortion.name, question: @cognitive_distortion.question }
    assert_redirected_to cognitive_distortion_path(assigns(:cognitive_distortion))
  end

  test "should destroy cognitive_distortion" do
    assert_difference('CognitiveDistortion.count', -1) do
      delete :destroy, id: @cognitive_distortion
    end

    assert_redirected_to cognitive_distortions_path
  end
end
