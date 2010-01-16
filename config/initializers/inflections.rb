# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )

  inflect.irregular 'racun', 'racuni'
  inflect.irregular 'gotovinski_racun', 'gotovinski_racuni'
  inflect.irregular 'ulazni_racun', 'ulazni_racuni'
  inflect.irregular 'ponuda', 'ponude'
  
  inflect.irregular 'izvod', 'izvodi'
  
  inflect.irregular 'izdatak', 'izdaci'
  inflect.irregular 'primitak', 'primici'
  inflect.irregular 'stavka', 'stavke'
  
  inflect.irregular 'racun_placanje', 'racuni_placanja'
  inflect.irregular 'ulazni_racun_placanje', 'ulazni_racuni_placanja'
  
  inflect.irregular "partner", "partneri"

end
