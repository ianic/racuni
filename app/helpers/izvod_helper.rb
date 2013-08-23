module IzvodHelper

  def link_to_dan(datum)
    link_to_remote datum['dan'],  :url=>{ :action => 'uplate_isplate', 'datum'=> datum['datum']},  :html => {:class => "inplace" }
  end

end
