module EditorsHelper
  
  def indicator(id)
    image_tag 'indicator.gif', :id => id, :style => 'display:none'
  end

  def notice
    "<div id='notice'>#{flash[:notice]}</div>" if flash[:notice]
  end

  def notice2
    "<div id='notice'>#{@notice}</div>" if @notice
  end

  def select_godina(selected, sve_godine = true)
    godine = (@user.godina_od..Date.today.year).to_a
    godine = ["..."] + godine if  sve_godine
    render_select('godina', godine, selected)
  end

  def select_placanje(selected)
    render_select('placanje', [ ["...", 0], ["dospjeli", 1], ["neplaceni", 2], ["placeni",  3] ], selected)
  end

  def select_nacin_placanja(selected)
    render_select('tip_placanja', [ ["...", -1], ["bezgotovinsko", 0], ["gotovinsko", 1] ], selected)
  end

  def select_mjesec(selected)
     render_select("mjesec", [
        ["...", ''],
        ['1', '1'], ['2', '2'], ['3', '3'], ['4', '4'], ['5', '5'], ['6', '6'], ['7', '7'], ['8', '8'], ['9', '9'], ['10', '10'], ['11', '11'], ['12', '12'],
        ['1-3', '1,2,3'], ['4-6', '4,5,6'], ['7-9', '7,8,9'], ['10-12', '10,11,12']
      ], selected)
  end

   def select_per_page(selected)
    render_select('per_page', [20, 50, 100, 1000], selected)
  end

  def render_select(name, collection, selected)
    "<select name='#{name}'>#{options_for_select(collection, selected)}</select>"
  end

  def even_odd(counter)
    (counter % 2 == 0)? "odd" : "even"
  end

  def form_start(title, highLight = false)
    hx = highLight ? "h3" : "h5"
    "<#{hx}>#{title}</#{hx}><table class='subForm' cellpadding='0' cellspacing='0'><tbody><tr><td>"
  end
  def form_end
    "</td></tr></tbody></table>"
  end
  def form_row_separator
    "</td></tr><tr><td>"
  end
  def form_element(title, content, with_separator = true)
    "<div class='formElement'><h6>#{title}</h6>#{content}</div>#{form_row_separator if with_separator}"
  end

  def render_paginator(pages, params = nil, filter_link = true, export_link = true)
    render :partial=>"common/paginator",
      :locals => {:pages => pages, :params => params, :filter_link => filter_link, :export_link => export_link}
  end

  def element(title, content)
    render_form_element("common/form_element", title, content)
  end
  def row_element(title, content)
    render_form_element("common/form_row_element", title, content)
  end
  def render_form_element(partial, title, content)
    render :partial => partial, :locals => { :title => title || '&nbsp;',  :content => content}
  end

  def render_collection(partial, collection, object_name)
    output = ""
    idx = 0
    collection.each do |object|
      output << render(:partial => partial, :locals => { object_name.to_sym => object, "#{object_name}_counter".to_sym => idx })
      idx += 1
    end
    output
  end

  def image_link(image, function, title = "")
    link_to_function image_tag(image, :title => title), function, :class => "img_link"
  end
  
end
