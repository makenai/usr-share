require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Member.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Member.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Member.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to member_url(assigns(:member))
  end

  def test_edit
    get :edit, :id => Member.first
    assert_template 'edit'
  end

  def test_update_invalid
    Member.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Member.first
    assert_template 'edit'
  end

  def test_update_valid
    Member.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Member.first
    assert_redirected_to member_url(assigns(:member))
  end

  def test_destroy
    member = Member.first
    delete :destroy, :id => member
    assert_redirected_to members_url
    assert !Member.exists?(member.id)
  end
end
