require 'test_helper'

class CoIndependentTraitsControllerTest < ActionController::TestCase
  setup do
    @co_independent_trait = co_independent_traits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:co_independent_traits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create co_independent_trait" do
    assert_difference('CoIndependentTrait.count') do
      post :create, co_independent_trait: { contents: @co_independent_trait.contents }
    end

    assert_redirected_to co_independent_trait_path(assigns(:co_independent_trait))
  end

  test "should show co_independent_trait" do
    get :show, id: @co_independent_trait
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @co_independent_trait
    assert_response :success
  end

  test "should update co_independent_trait" do
    patch :update, id: @co_independent_trait, co_independent_trait: { contents: @co_independent_trait.contents }
    assert_redirected_to co_independent_trait_path(assigns(:co_independent_trait))
  end

  test "should destroy co_independent_trait" do
    assert_difference('CoIndependentTrait.count', -1) do
      delete :destroy, id: @co_independent_trait
    end

    assert_redirected_to co_independent_traits_path
  end
end
