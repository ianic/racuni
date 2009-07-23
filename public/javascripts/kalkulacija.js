Number.prototype.round_to = function(decimals){
  return parseFloat(this.toFixed(decimals ? decimals : 2));
}

var KalkulacijaStavka = Class.create();
KalkulacijaStavka.prototype = {
  
  initialize: function(options) {
    options = Object.extend(options || {});
    
    this.kolicina = parseFloat(options.kolicina) || 0.0;
    this.cijena = parseFloat(options.cijena) || 0.0;    
    this.popust_postotak = parseFloat(options.popust_postotak) || 0.0;
    this.trosak = parseFloat(options.trosak) || 0.0;
    this.marza_postotak = parseFloat(options.marza_postotak) || 0.0;
    this.porez_postotak = parseFloat(options.porez_postotak) || 22.0;
    
    this.index = 0;
    
    this.izracun();
  },
  
  e: function(name){
    return $("stavka_" + this.index + "_" + name);
  },
  
  bindElements: function(){    
    this.e("kolicina").onchange = this.onChange.bindAsEventListener(this);
    this.e("cijena").onchange = this.onChange.bindAsEventListener(this);
    this.e("trosak").onchange = this.onChange.bindAsEventListener(this);
    this.e("popust_postotak").onchange = this.onChange.bindAsEventListener(this);
    this.e("marza_postotak").onchange = this.onChange.bindAsEventListener(this);
    this.e("porez_postotak").onchange = this.onChange.bindAsEventListener(this);  
    this.e("cijena_bez_poreza").onchange = this.onCijenaBezChange.bindAsEventListener(this);
    this.e("cijena_s_porezom").onchange = this.onCijenaSChange.bindAsEventListener(this);
  },
  
  read: function(prefix){
    this.kolicina = parseFloat(this.e("kolicina").value);
    this.cijena = parseFloat(this.e("cijena").value);
    this.trosak = parseFloat(this.e("trosak").value);
    this.popust_postotak = parseFloat(this.e("popust_postotak").value);
    this.marza_postotak = parseFloat(this.e("marza_postotak").value);
    this.porez_postotak = parseFloat(this.e("porez_postotak").value);
    this.cijena_bez_poreza = parseFloat(this.e("cijena_bez_poreza").value);
    this.cijena_s_porezom = parseFloat(this.e("cijena_s_porezom").value);    
  },
  
  write: function(prefix){
    this.e("kolicina").value = this.kolicina.toFixed(2);
    this.e("cijena").value = this.cijena.toFixed(2);
    this.e("vrijednost").value = this.vrijednost.toFixed(2);
    
    this.e("popust_postotak").value = this.popust_postotak.toFixed(2);
    this.e("popust").value = this.popust.toFixed(2);
    
    this.e("fakturna_cijena").value = this.fakturna_cijena.toFixed(2);
    this.e("fakturna_vrijednost").value = this.fakturna_vrijednost.toFixed(2);
    
    this.e("trosak").value = this.trosak.toFixed(2);
    
    this.e("nabavna_cijena").value = this.nabavna_cijena.toFixed(2);
    this.e("nabavna_vrijednost").value = this.nabavna_vrijednost.toFixed(2);
    
    this.e("marza_postotak").value = this.marza_postotak.toFixed(2);
    this.e("marza").value = this.marza.toFixed(2);
    
    this.e("porez_postotak").value = this.porez_postotak.toFixed(2);
    this.e("porez").value = this.porez.toFixed(2);
    
    this.e("cijena_bez_poreza").value = this.cijena_bez_poreza.toFixed(2);
    this.e("vrijednost_bez_poreza").value = this.vrijednost_bez_poreza.toFixed(2);
    
    this.e("cijena_s_porezom").value = this.cijena_s_porezom.toFixed(2);
    this.e("vrijednost_s_porezom").value = this.vrijednost_s_porezom.toFixed(2);
  },
  
  onChange: function(){
    this.read();    
    this.izracun();
    this.write();
  },
  
  onCijenaBezChange: function(){
    this.read();
    this.vrijednost_bez_poreza = this.cijena_bez_poreza * this.kolicina;
    this.marza_postotak = (this.vrijednost_bez_poreza - this.nabavna_vrijednost) / this.nabavna_vrijednost * 100;
    this.izracun();
    this.write();
  },
  
  onCijenaSChange: function(){
    this.read();
    this.vrijednost_s_porezom = this.cijena_s_porezom * this.kolicina;
    this.vrijednost_bez_poreza = this.vrijednost_s_porezom / (1 + this.porez_postotak / 100);   
    this.marza_postotak = (this.vrijednost_bez_poreza - this.nabavna_vrijednost) / this.nabavna_vrijednost * 100;
    this.izracun();
    this.write();
  },
  
  izracun: function(){
    this.porez_postotak = this.postotak_min_max(this.porez_postotak);
    this.popust_postotak = this.postotak_min_max(this.popust_postotak);
    
    this.vrijednost = (this.kolicina * this.cijena).round_to();
    
    this.fakturna_vrijednost = this.postotak(this.vrijednost, -this.popust_postotak).round_to();
    this.nabavna_vrijednost = (this.fakturna_vrijednost + this.trosak).round_to();
    this.vrijednost_bez_poreza =  this.postotak(this.nabavna_vrijednost, this.marza_postotak).round_to();
    this.vrijednost_s_porezom =  this.postotak(this.vrijednost_bez_poreza, this.porez_postotak).round_to();
    
    this.porez = (this.vrijednost_s_porezom - this.vrijednost_bez_poreza).round_to();
    this.marza = (this.vrijednost_bez_poreza - this.nabavna_vrijednost).round_to();
    this.popust = (this.vrijednost - this.fakturna_vrijednost).round_to();
    
    this.fakturna_cijena =  (this.fakturna_vrijednost / this.kolicina).round_to();          
    this.nabavna_cijena = (this.nabavna_vrijednost / this.kolicina).round_to();        
    this.cijena_bez_poreza = (this.vrijednost_bez_poreza / this.kolicina).round_to();        
    this.cijena_s_porezom = (this.vrijednost_s_porezom / this.kolicina).round_to();
        
  },
  
  postotak: function(iznos, posto){
    return iznos * ( 100 + posto ) / 100 
  },
  
  postotak_min_max: function(posto){
    return Math.min(Math.max(0, posto), 100);    
  }
 
}