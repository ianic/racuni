function to_f(s, def)
{
  f = parseFloat(s);
  if (isNaN(f))
    f = ((def == null) ? 0 : def);
  return f;
}

var RacunEdit = Class.create();
RacunEdit.prototype = {
        initialize: function()
  {
        this.stavke = new Array();

        $('racun_popust_postotak').onchange = this.izracunajIznos.bindAsEventListener(this);
                $('racun_pdv_postotak').onchange = this.izracunajIznos.bindAsEventListener(this);
                $('racun_osnovica').onchange = this.izracunajIznos.bindAsEventListener(this);
                if (this.ima_ostale_troskove())
                  $('racun_ostali_troskovi').onchange = this.izracunajIznos.bindAsEventListener(this);

                $('racun_popust').onchange = this.onPopustChanged.bindAsEventListener(this);

  },

  novaStavka: function(url)
  {
        Element.toggle('link_nova');
        Element.toggle('link_nova_indicator');
        index = this.stavke.length;
        new Ajax.Request(url + '?index=' + index,
                {asynchronous:true, evalScripts:true,
                onComplete:function(request)
                        {
                                new Insertion.Bottom('stavke', request.responseText);
                                s = new StavkaEdit(index);
                                racun.dodajStavku(s);
                                Element.toggle('link_nova');
                                Element.toggle('link_nova_indicator');
                                s.highlight();
                        }});
  },

  dodajStavku: function(s)
  {
        this.stavke[this.stavke.length] = s;
        this.enable();
  },

  brisiStavku: function(stavka)
  {
    for(idx=0;idx<this.stavke.length;idx++)
          if (this.stavke[idx] == stavka)
            this.stavke.splice(idx, 1);
        this.enable();
        this.izracunajIznos();
  },

  izracunajIznos: function()
  {
        osnovica = this.osnovica();
        popust_postotak = this.popust_postotak();
        pdv_postotak = this.pdv_postotak();
        ostali_troskovi = this.ostali_troskovi();

        popust = osnovica * popust_postotak / 100;
        pdv = (osnovica - popust) * pdv_postotak / 100;
        iznos = osnovica - popust + pdv + ostali_troskovi;

        $('racun_popust_postotak').value = popust_postotak.toFixed(2);
        $('racun_pdv_postotak').value = pdv_postotak.toFixed(2);
        $('racun_osnovica').value = osnovica.toFixed(2);
        $('racun_popust').value = popust.toFixed(2);
        $('racun_pdv').value = pdv.toFixed(2);
        if (this.ima_ostale_troskove())
          $('racun_ostali_troskovi').value = ostali_troskovi.toFixed(2);
        $('racun_iznos').value = iznos.toFixed(2);
  },

  provjeriPostotak: function(p)
  {
    if (p < 0 || p > 100)
      return 0;
    else
      return p;
  },

  popust_postotak: function()
  {
    return this.provjeriPostotak(to_f($F('racun_popust_postotak')));
  },

  pdv_postotak: function()
  {
    return this.provjeriPostotak(to_f($F('racun_pdv_postotak')));
  },

  popust: function()
  {
    return to_f($F('racun_popust'));
  },

  ima_ostale_troskove: function()
  {
    return $('racun_ostali_troskovi') != null;
  },

  ostali_troskovi: function()
  {
    if (this.ima_ostale_troskove())
      return to_f($F('racun_ostali_troskovi'));
    else
      return 0;
  },

  osnovica: function()
  {
    if (this.ima_stavki())
    {
      o = 0
          for(idx=0;idx<this.stavke.length;idx++)
                        o += this.stavke[idx].osnovica;
                return o;
    }
    else
    {
      return to_f($F('racun_osnovica'))
    }
  },

  onPopustChanged: function()
  {
    $('racun_popust_postotak').value = this.dijeli(this.popust(), this.osnovica()) * 100;
    this.izracunajIznos();
  },

  onPdvChanged: function()
  {
    $('racun_pdv_postotak').value =  this.dijeli(to_f($F('racun_pdv')), this.osnovica() - this.popust()) * 100;
    this.izracunajIznos();
  },

  dijeli: function(b, n)
  {
    return n == 0 ? 0 : b / n;
  },

  onsubmit: function()
  {
    $("racun_osnovica").disabled = false;
    $("racun_iznos").disabled = false;
    $("racun_pdv").disabled = false;
    $("racun_popust").disabled = false;
  },

  ima_stavki: function()
  {
    return this.stavke.length > 0;
  },

  enable: function()
  {
    $('racun_osnovica').disabled = this.ima_stavki();
  }
}

var StavkaEdit = Class.create();
StavkaEdit.prototype = {
        next_id: 0,

         initialize: function(index)
         {
                 this.opis = $("stavka_" + index + "_opis");
                 this.kolicina = $("stavka_" + index + "_kolicina");
                 this.cijena = $("stavka_" + index + "_cijena");
                 this.iznos = $("stavka_" + index + "_iznos");
                 this.imgBrisi = $("stavka_" + index + "_brisi")
                 this.div = $("stavka_" + index)
                 this.bind();
         },

         bind: function()
         {
                 this.kolicina.onblur = this.izracunajIznos.bindAsEventListener(this);
                 this.cijena.onblur = this.izracunajIznos.bindAsEventListener(this);
                 CE.registerAll(this.div);
                 this.imgBrisi.onclick = this.brisi.bindAsEventListener(this);
                 Field.focus(this.opis);
                 this.izracunajIznos();
         },

         highlight: function()
         {
                new Effect.Highlight(this.div);
         },

   izracunajIznos: function(evt) {
                 kolicina = to_f($F(this.kolicina), 1);
                 cijena = to_f($F(this.cijena));
                 iznos = kolicina * cijena;
                 iznos = isNaN(iznos) ? 0 : iznos;
                 this.kolicina.value = kolicina; //.toFixed(2);
                 this.cijena.value = cijena.toFixed(2);
                 this.iznos.value = iznos.toFixed(2);
                 this.osnovica = iznos;
                 racun.izracunajIznos();
   },

   prazna: function()
   {
                        return ((this.opis.value.length == 0) && (to_f($F(this.iznos)) == 0));
   },

   brisi: function(){
        if (!this.prazna())
                if (!confirm('Brisanje stavke?'))
                        return;
        Element.remove(this.div);
        racun.brisiStavku(this);
   }
};

var HTMLElements = {
        railsName: function(object, attribute, id)
        {
                return object + "[" + id + "][" + attribute + "]";
        },

  textInput: function(id, value, name)
  {
                input = document.createElement('input');
                input.id = id;
                input.name = name;
                input.value = value;
                return input;
        },

        textAreaInput: function(id, value, name)
  {
                input = document.createElement('textarea');
                input.id = id;
                input.name = name;
                input.innerHTML = value;
                return input;
        },

        createElement: function(type, id, innerHTML)
  {
                e = document.createElement(type);
        e.id = id;
        e.innerHTML = innerHTML;
        return e;
  },

  createImage: function(id, src, alt)
  {
                i = document.createElement('img');
          i.id = id;
          i.src = src;
          i.alt = alt;
          i.border = 0;
          return i;
        }
}

var FormKeyController = Class.create();
FormKeyController.prototype = {
                initialize: function()
                {
                        //this.form = document.forms[0];
                },

                focusNext: function(evt)
                {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode :
                ((evt.which) ? evt.which : evt.keyCode);
            if (charCode == 13 || charCode == 3) {
                //this.form.elements[elemName].focus( );
                return false;
            }
            return true;
                },

                add: function(control)
                {
                        $(control).onkeypress = this.focusNext(this);
                }
}

