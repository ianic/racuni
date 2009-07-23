require File.dirname(__FILE__) + '/../test_helper'

class KupacTest < Test::Unit::TestCase
  fixtures :kupac

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Kupac, kupac(:first)
  end
end
