require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Account.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Account.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Account.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to account_url(assigns(:account))
  end

  def test_edit
    get :edit, :id => Account.first
    assert_template 'edit'
  end

  def test_update_invalid
    Account.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Account.first
    assert_template 'edit'
  end

  def test_update_valid
    Account.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Account.first
    assert_redirected_to account_url(assigns(:account))
  end

  def test_destroy
    account = Account.first
    delete :destroy, :id => account
    assert_redirected_to accounts_url
    assert !Account.exists?(account.id)
  end
end
