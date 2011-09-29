require 'test_helper'

class MediaTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => MediaType.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    MediaType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    MediaType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to media_type_url(assigns(:media_type))
  end

  def test_edit
    get :edit, :id => MediaType.first
    assert_template 'edit'
  end

  def test_update_invalid
    MediaType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => MediaType.first
    assert_template 'edit'
  end

  def test_update_valid
    MediaType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => MediaType.first
    assert_redirected_to media_type_url(assigns(:media_type))
  end

  def test_destroy
    media_type = MediaType.first
    delete :destroy, :id => media_type
    assert_redirected_to media_types_url
    assert !MediaType.exists?(media_type.id)
  end
end
