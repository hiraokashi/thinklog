require 'test_helper'

class AdultChildrenTraitsControllerTest < ActionController::TestCase
  setup do
    @adult_children_trait = adult_children_traits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adult_children_traits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adult_children_trait" do
    assert_difference('AdultChildrenTrait.count') do
      post :create, adult_children_trait: { contents: @adult_children_trait.contents }
    end

    assert_redirected_to adult_children_trait_path(assigns(:adult_children_trait))
  end

  test "should show adult_children_trait" do
    get :show, id: @adult_children_trait
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adult_children_trait
    assert_response :success
  end

  test "should update adult_children_trait" do
    patch :update, id: @adult_children_trait, adult_children_trait: { contents: @adult_children_trait.contents }
    assert_redirected_to adult_children_trait_path(assigns(:adult_children_trait))
  end

  test "should destroy adult_children_trait" do
    assert_difference('AdultChildrenTrait.count', -1) do
      delete :destroy, id: @adult_children_trait
    end

    assert_redirected_to adult_children_traits_path
  end
end
