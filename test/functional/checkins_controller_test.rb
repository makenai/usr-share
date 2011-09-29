require 'test_helper'

class CheckinsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Checkin.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Checkin.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Checkin.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to checkin_url(assigns(:checkin))
  end

  def test_edit
    get :edit, :id => Checkin.first
    assert_template 'edit'
  end

  def test_update_invalid
    Checkin.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Checkin.first
    assert_template 'edit'
  end

  def test_update_valid
    Checkin.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Checkin.first
    assert_redirected_to checkin_url(assigns(:checkin))
  end

  def test_destroy
    checkin = Checkin.first
    delete :destroy, :id => checkin
    assert_redirected_to checkins_url
    assert !Checkin.exists?(checkin.id)
  end
end
