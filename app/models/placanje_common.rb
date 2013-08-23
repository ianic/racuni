# encoding: utf-8

module PlacanjeCommon

	def validate_on_create
		errors.add("iznos", "upište iznos") if iznos <= 0 && racun.tip_placanja == 0
		errors.add("iznos", "mora biti manji ili jednak #{racun.za_naplatu}") if (iznos > racun.za_naplatu && racun.tip_placanja == 0)
	end

	def broj
	  racun.broj
	end

	def partner
	  racun.partner
	end

	def bez_poreza
	  iznos - pdv
	end

	def pdv_kategorija
	  racun.pdv_kategorija
	end

	def porezna_osnovica
	  ((racun.osnovica - racun.popust) * placeni_dio).round_at(2)
	end

	def pdv
		(racun.pdv * placeni_dio).round_at(2)
	end

	def placeni_dio
	  racun.iznos > 0 ? iznos / racun.iznos : 0
	end

	def pdv_moze_se_odbiti
	  racun.tip_predporeza == 0 ? pdv : 0
	end

	def pdv_nemoze_se_odbiti
	  racun.tip_predporeza == 1 ? pdv : 0
	end

	def izvod_dokument
	  racun
	end

	def izvod_opis
	  dokument
	end

	def partner
	  racun.partner
	end

	def after_save
	  racun.user.update_attribute('zadnji_izvod', self.dokument) if racun.user
	end

end
