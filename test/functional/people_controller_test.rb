require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Person.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Person.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Person.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to person_url(assigns(:person))
  end

  def test_edit
    get :edit, :id => Person.first
    assert_template 'edit'
  end

  def test_update_invalid
    Person.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Person.first
    assert_template 'edit'
  end

  def test_update_valid
    Person.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Person.first
    assert_redirected_to person_url(assigns(:person))
  end

  def test_destroy
    person = Person.first
    delete :destroy, :id => person
    assert_redirected_to people_url
    assert !Person.exists?(person.id)
  end
end
