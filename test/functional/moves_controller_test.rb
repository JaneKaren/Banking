require 'test_helper'

class MovesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Move.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Move.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Move.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to move_url(assigns(:move))
  end

  def test_edit
    get :edit, :id => Move.first
    assert_template 'edit'
  end

  def test_update_invalid
    Move.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Move.first
    assert_template 'edit'
  end

  def test_update_valid
    Move.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Move.first
    assert_redirected_to move_url(assigns(:move))
  end

  def test_destroy
    move = Move.first
    delete :destroy, :id => move
    assert_redirected_to moves_url
    assert !Move.exists?(move.id)
  end
end
