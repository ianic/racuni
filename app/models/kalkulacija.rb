class Kalkulacija < ActiveRecord::Base
  belongs_to :user
  belongs_to :partner
  include Dokument
  
end
