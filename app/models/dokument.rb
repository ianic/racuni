require 'uuidtools'

module Dokument

  def broj_dokumenta
    "#{broj}-01-01"
  end

  def after_initialize
    if new_record?
      (self.datum = Date.today )if !self.datum
    end
  end

  def before_save
    if new_record?
      dodjeli_broj
      set_uuid
    end
    if self.respond_to?("on_before_save")
      on_before_save
    end
  end

  def dodjeli_broj
    self.godina = self.datum.year
    self.broj = slijedeci_broj
  end

  def set_uuid
    if self.respond_to?('uuid')
      self.uuid =  UUIDTools::UUID.random_create.to_s
    end
  end

  def slijedeci_broj
    zadnji = self.class.maximum(:broj, :conditions => "godina = #{self.godina} and user_id = #{self.user_id}")
    zadnji ? zadnji.to_i + 1 : 1
  end

  def broj_godina(str)
    a = str.split(/\D/).map {|s| s.empty? ? nil : s }.compact
    godina = a.size > 1 ? a[1].to_i : Date.today.year
    godina = godina + 2000 if godina < 100
    return [a[0].to_i, godina]
  end

  def zamjeni_partnera(novi)
    logger.info("zamjena partnera #{self.partner_id} partnerom #{novi.id} na dokumentu #{self.class} id #{self.id}")
    logger.info("\trollback:\t update #{self.class.table_name} set partner_id = #{self.partner_id} where id = #{self.id}")
    update_attribute('partner_id', novi.id)
  end

end
