require File.dirname(__FILE__) + '/../test_helper'

class PartnerTest < Test::Unit::TestCase
  fixtures :partner

  def setup
    @partner = Partner.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Partner,  @partner
  end
end
