class Primitak < ActiveRecord::Base

  include PrimitakIzdatakCommon
  belongs_to :partner
  belongs_to :user

  validates_presence_of :opis
  validates_numericality_of :iznos
  validates_exclusion_of :iznos, :in => 0..0

end
