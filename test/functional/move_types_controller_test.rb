require 'test_helper'

class MoveTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => MoveType.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    MoveType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    MoveType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to move_type_url(assigns(:move_type))
  end

  def test_edit
    get :edit, :id => MoveType.first
    assert_template 'edit'
  end

  def test_update_invalid
    MoveType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => MoveType.first
    assert_template 'edit'
  end

  def test_update_valid
    MoveType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => MoveType.first
    assert_redirected_to move_type_url(assigns(:move_type))
  end

  def test_destroy
    move_type = MoveType.first
    delete :destroy, :id => move_type
    assert_redirected_to move_types_url
    assert !MoveType.exists?(move_type.id)
  end
end
