require File.dirname(__FILE__) + '/../test_helper'
require 'racun_controller'

# Re-raise errors caught by the controller.
class RacunController; def rescue_action(e) raise e end; end

class RacunControllerTest < Test::Unit::TestCase
  fixtures :racun, :racun_stavka, :racun_placanje

  def setup
    @controller = RacunController.new
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

    assert_not_nil assigns(:racuns)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:racun)
    assert assigns(:racun).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:racun)
  end

  def test_create
    num_racuns = Racun.count

    post :create, :racun => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_racuns + 1, Racun.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:racun)
    assert assigns(:racun).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Racun.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Racun.find(1)
    }
  end
end
