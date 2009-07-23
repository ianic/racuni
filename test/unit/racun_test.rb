require File.dirname(__FILE__) + '/../test_helper'

class RacunTest < Test::Unit::TestCase
  fixtures :racun, :racun_placanje, :racun_stavka

  def setup
    @racun = Racun.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Racun,  @racun
    assert_equal 1, @racun.id
    assert_equal 100, @racun.placeno
		assert_equal 2, @racun.stavke.size
		assert_equal 100, @racun.stavke[0].iznos
    assert_equal 244, @racun.iznos
    assert_equal 44, @racun.slijedeci_broj
  end
   
end
