require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Room.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Room.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Room.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to room_url(assigns(:room))
  end

  def test_edit
    get :edit, :id => Room.first
    assert_template 'edit'
  end

  def test_update_invalid
    Room.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Room.first
    assert_template 'edit'
  end

  def test_update_valid
    Room.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Room.first
    assert_redirected_to room_url(assigns(:room))
  end

  def test_destroy
    room = Room.first
    delete :destroy, :id => room
    assert_redirected_to rooms_url
    assert !Room.exists?(room.id)
  end
end
