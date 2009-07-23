require File.dirname(__FILE__) + '/../test_helper'
require 'kupac_controller'

# Re-raise errors caught by the controller.
class KupacController; def rescue_action(e) raise e end; end

class KupacControllerTest < Test::Unit::TestCase
  fixtures :kupac

  def setup
    @controller = KupacController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:kupacs)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:kupac)
    assert assigns(:kupac).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:kupac)
  end

  def test_create
    num_kupacs = Kupac.count

    post :create, :kupac => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_kupacs + 1, Kupac.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:kupac)
    assert assigns(:kupac).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Kupac.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Kupac.find(1)
    }
  end
end
