require 'test_helper'

class MediaLocationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => MediaLocation.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    MediaLocation.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    MediaLocation.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to media_location_url(assigns(:media_location))
  end

  def test_edit
    get :edit, :id => MediaLocation.first
    assert_template 'edit'
  end

  def test_update_invalid
    MediaLocation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => MediaLocation.first
    assert_template 'edit'
  end

  def test_update_valid
    MediaLocation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => MediaLocation.first
    assert_redirected_to media_location_url(assigns(:media_location))
  end

  def test_destroy
    media_location = MediaLocation.first
    delete :destroy, :id => media_location
    assert_redirected_to media_locations_url
    assert !MediaLocation.exists?(media_location.id)
  end
end
