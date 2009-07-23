require File.dirname(__FILE__) + '/../test_helper'
require 'analize_controller'

# Re-raise errors caught by the controller.
class AnalizeController; def rescue_action(e) raise e end; end

class AnalizeControllerTest < Test::Unit::TestCase
  def setup
    @controller = AnalizeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
