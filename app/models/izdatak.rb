class Izdatak < ActiveRecord::Base		  
  include Dokument
  include PrimitakIzdatakCommon
  belongs_to :partner
  belongs_to :user
  
  validates_presence_of :opis
  validates_numericality_of :iznos
  validates_exclusion_of :iznos, :in => 0..0
  
  TIP_UPLATE = [
    ["na žiro", 0],
    ["u gotovini", 1],
    ["u naravi", 2],
  ]
   
end
