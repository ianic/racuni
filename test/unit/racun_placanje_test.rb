require File.dirname(__FILE__) + '/../test_helper'

class RacunPlacanjeTest < Test::Unit::TestCase
  fixtures :racun, :racun_placanje, :racun_stavka

  def setup
    @racun_placanje = RacunPlacanje.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of RacunPlacanje,  @racun_placanje
  end  
  
   def test_dodaj_placanje
   	racun = Racun.find(1)
  	assert_equal 100, racun.placeno
  	assert_equal 244, racun.iznos
  	assert_equal false, racun.placen
  	
  	placanje = RacunPlacanje.new(:iznos => 100, :racun_id => racun.id)
  	assert_equal true, placanje.save
  	racun.placanja(true)
    assert_equal 200, racun.placeno
    assert_equal 44, racun.za_naplatu
    
    placanje = racun.placanja.create(:iznos => 44)
  	assert_equal true, placanje.errors.empty?
    assert_equal 244, racun.placeno
    assert_equal 0, racun.za_naplatu
    assert_equal true, racun.placen
  	  	
  	assert_equal 3, racun.placanja.size
  	placanje = racun.placanja.create(:iznos => 0.01)  	
  	assert_equal false, placanje.errors.empty?
  	racun.placanja(true)
  	assert_equal 244, racun.placeno
  	assert_equal 3, racun.placanja.size
  end
end
