module PartnerHelper

 def exists?(field)
  return false if field == nil
  return false if field.size == 0
  return true
 end

  def render_partner_select(p, clear_button = true, input_filed_id = "partner_id", input_filed_name = "partner_id")
		render :partial => "partner/select", 
			:locals => {	
				:partner => to_partner(p), 
				:url => url_for(:controller => 'partner', :action => 'select'),
				:input_filed_id => input_filed_id,
				:input_filed_name => input_filed_name,
				:clear_button => clear_button			
			}
	end
	
  def partner_select(object_name, method)
	  p = to_object(object_name).send(method)
	  render_partner_select(p, false, "#{object_name}_#{method}_id", "#{object_name}[#{method}_id]")# +
	end
	  
  def render_partner(p)
    p = to_partner(p)
    if p
      render(:partial=>'partner/partner', :object => p) 
    else
      ""
    end
  end
  
  def render_partner_view(p)
    render(:partial=>'partner/view', :object => to_partner(p))
  end
  
  def to_partner(o)
    return o if o.class == Partner	    
    return (Partner.find(o) rescue nil) if (o.class == Fixnum and o.to_i > 0)
    return o.partner rescue nil
    nil
  end 
 
end
