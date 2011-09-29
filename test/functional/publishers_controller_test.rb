require 'test_helper'

class PublishersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Publisher.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Publisher.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Publisher.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to publisher_url(assigns(:publisher))
  end

  def test_edit
    get :edit, :id => Publisher.first
    assert_template 'edit'
  end

  def test_update_invalid
    Publisher.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Publisher.first
    assert_template 'edit'
  end

  def test_update_valid
    Publisher.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Publisher.first
    assert_redirected_to publisher_url(assigns(:publisher))
  end

  def test_destroy
    publisher = Publisher.first
    delete :destroy, :id => publisher
    assert_redirected_to publishers_url
    assert !Publisher.exists?(publisher.id)
  end
end
