require File.dirname(__FILE__) + '/../test_helper'

class HelpTest < Test::Unit::TestCase
  fixtures :help

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Help, help(:first)
  end
end
