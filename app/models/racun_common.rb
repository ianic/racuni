# encoding: utf-8

# -*- coding: utf-8 -*-
module RacunCommon
  include Dokument

  extend ActiveSupport::Concern

  included do
    before_save :before_save
    after_initialize :after_initialize
  end

  def edit(attributes, stavke_attributes)
    self.update_attributes(attributes)
    self.stavke.delete_all
    stavke_attributes.each do |attr_a|
      attr = attr_a[1]
      self.stavke << RacunStavka.new(
        :stavka_id => self.user.stavka(attr[:opis], attr[:jedinica_mjere], attr[:cijena]).id,
        :cijena => attr[:cijena],
        :kolicina => attr[:kolicina])
    end if stavke_attributes

    self.save
  end

  def rok_placanja=(value)
    write_attribute('rok_placanja', value.to_i)
  end

  def dospjece
    self.datum + self.rok_placanja
  end

  def za_naplatu
    iznos - placeno
  end

  def bez_poreza
    iznos - pdv
  end

  def porezna_osnovica
    osnovica - popust
  end

  def kasni
    return 0 if placen
    days = (Date.today - self.dospjece).to_i
    days > 0 ? days : 0
  end

  def kasni?
    kasni > 0
  end

  def neplacen?
    placeno == 0
  end

  def popust?
    popust_postotak > 0
  end

  def djelomicno_placen?
    return false if placeno == 0
    za_naplatu.abs >= 0.01
  end

  def update_placeno(placanje)
    if !(self.respond_to?('tip_placanja') && self.tip_placanja == 1)
      self.save
    end
  end

  def on_before_save
    return if !self.respond_to?('placeno')
    return if !self.respond_to?('tip_placanja')
    return if new_record?
    if (self.respond_to?('tip_placanja') && self.tip_placanja == 1)
      self.placeno = iznos
      self.placen = 1
    else
      self.placeno = (self.placanja(true).inject(0) { |n, placanje| n + placanje.iznos }).round_at(2)
      self.placen = self.placeno >= self.iznos ? 1 : 0
    end
  end

  def after_save
    return if !self.respond_to?('tip_placanja')
    if (self.respond_to?('tip_placanja') && self.tip_placanja == 1)
      self.placanja.clear
      self.placanja.create(:datum => self.datum, :iznos => self.iznos, :tip_uplate => 1, :dokument => '')
    end
  end

  #za demo podatke, ne ra�una poust ternutno
  def izracunaj_iznose
    self.osnovica = (self.stavke(true).inject(0) { |n, stavka| n + stavka.iznos })
    self.pdv = self.osnovica * self.pdv_postotak / 100
    self.iznos = self.osnovica + self.pdv
    self.popust = 0
    self.popust_postotak = 0
  end

  def racun
    self
  end

  def gotovinski?
    return false if self.class == Ponuda
    tip_placanja == 1
  end

  def broj_opis
    gotovinski? ? "#{broj} G" : broj
  end

  def racun?
    return self.class == Racun && !self.gotovinski?
  end

  def izlazni?
    return self.class == Racun
  end

  def ponuda?
    return self.class == Ponuda
  end

  def ima_sifru?
    ima = false
    stavke.each do |stavka|
       ima = true if stavka.ima_sifru?
    end
    ima
  end

  def broj_narudzbe?
    broj_narudzbe.to_s.strip.size > 0
  rescue
    false
  end

  def izvoz?
    pdv_kategorija == "I.2.2"
  rescue
    false
  end

end
