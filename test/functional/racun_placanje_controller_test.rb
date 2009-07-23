require File.dirname(__FILE__) + '/../test_helper'
require 'racun_placanje_controller'

# Re-raise errors caught by the controller.
class RacunPlacanjeController; def rescue_action(e) raise e end; end

class RacunPlacanjeControllerTest < Test::Unit::TestCase
  fixtures :racun_placanje

  def setup
    @controller = RacunPlacanjeController.new
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

    assert_not_nil assigns(:racun_placanjes)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:racun_placanje)
    assert assigns(:racun_placanje).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:racun_placanje)
  end

  def test_create
    num_racun_placanjes = RacunPlacanje.count

    post :create, :racun_placanje => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_racun_placanjes + 1, RacunPlacanje.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:racun_placanje)
    assert assigns(:racun_placanje).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil RacunPlacanje.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      RacunPlacanje.find(1)
    }
  end
end
