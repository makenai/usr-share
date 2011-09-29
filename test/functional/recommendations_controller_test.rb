require 'test_helper'

class RecommendationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Recommendation.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Recommendation.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Recommendation.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to recommendation_url(assigns(:recommendation))
  end

  def test_edit
    get :edit, :id => Recommendation.first
    assert_template 'edit'
  end

  def test_update_invalid
    Recommendation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Recommendation.first
    assert_template 'edit'
  end

  def test_update_valid
    Recommendation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Recommendation.first
    assert_redirected_to recommendation_url(assigns(:recommendation))
  end

  def test_destroy
    recommendation = Recommendation.first
    delete :destroy, :id => recommendation
    assert_redirected_to recommendations_url
    assert !Recommendation.exists?(recommendation.id)
  end
end
