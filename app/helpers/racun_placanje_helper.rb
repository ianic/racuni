# encoding: utf-8

module RacunPlacanjeHelper

  def link_to_delete_placajne(placanje_id, racun_id)
    link_to_remote image_tag('delete.gif'), 
			  {	:url=>{ :action => 'delete_placanje', :placanje_id => placanje_id, :id => racun_id }, 						
				  :confirm => "Brisanje uplate?",
				  :complete => "new Effect.Highlight('placanje')"
			  }
  end
  
  def link_to_add_placanje(racun_id)
    submit_to_remote("btnSave", "UPIŠI",
      :url=>{:action=>'add_placanje', :id => racun_id },
	    :complete => "new Effect.Highlight('placanje')",
	    :html => {:class => "button" }
      )
  end
  
end
