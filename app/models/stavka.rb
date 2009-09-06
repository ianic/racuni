class Stavka < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :opis
  validates_numericality_of :cijena

  def kolicina
    attributes['kolicina'].to_f
  end

  def iznos
    attributes['iznos'].to_f
  end

  def broj_racuna
    attributes['broj_racuna'].to_i
  end 
  
end
