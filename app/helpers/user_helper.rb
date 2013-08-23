# encoding: utf-8

module UserHelper

	def novi_racun
	  link_to "Novi", :controller => @controller , :action => :new
	end
	
	def dospjeli
	  link_to "Dospjeli neplaćeni", :controller => @controller , :action => :filter, :placanje => 1, :godina => 0
	end
	
	def neplaceni
	  link_to "Neplaćeni", :controller => @controller, :action => :filter, :placanje => 2, :godina => 0
	end
	
	def pregled 
	  link_to "Pregled", :controller => @controller, :action => :filter
	end
  
end
