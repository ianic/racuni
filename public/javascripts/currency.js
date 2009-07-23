var CurrencyEdit = Class.create();
CurrencyEdit.prototype = {
  initialize: function()
  {
    this.registered = new Array();
  },

  register: function(element)
  {
    if (this.alreadyRegistered(element))
        return;

    Event.observe(element, 'keyup', function(e)
    {
      if (e.keyCode == 188)
      {
        el = e.target || e.srcElement;
        ss = el.selectionStart;
        se = el.selectionEnd;
        el.value = el.value.gsub(',','.');
        el.selectionStart = ss;
        el.selectionEnd = se;
      }
    }, false);

    Event.observe(element, 'keypress', function(event)
    {
      //spetljano zato što IE i Firefox imaju drugčije kodove

      var e = event || window.event;
      var code = e.charCode || e.keyCode;

      //dozvoli sve kontrole strelice,home,end...
      if (e.charCode == 0) return true;
      if (e.ctrlKey || e.altKey || e.metaKey) return true;
      if (code < 32 && e.charCode) return true;   //Firefox
      if (code < 44 && !e.charCode) return true;  //IE

      //ako nije broj,točka,zarez zabrani
      if (!(code == 44 || code == 46 || code == 188 || code == 190
            || (code > 47 && code < 59)) || (code > 47 && code < 59  && e.shiftKey)) {
        Event.stop(e);
        e.returnValue = false;
        return false;
      }

       return true;
    }, false);

     this.registered[this.registered.length] = element;
  },


  alreadyRegistered: function(element)
  {
      for(var i=0; i<this.registered.length; i++)
          if(this.registered[i] == element)
              return true;
      return false;
  },

  registerAll: function(root)
  {
    elements = Try.these(
      function() { return root.getElementsByTagName('input') },
      function() { return document.getElementsByTagName('input') }
    );
    for(var i = 0; i < elements.length; i++)
    {
      element = elements[i];
      if (element.type != "text") continue;
      var currency= element.getAttribute("currency");
      if (!currency) continue;
      CE.register(element);
    }
  },

  onComplete: function()
  {
    this.registerAll();
  }

}


var CE = new CurrencyEdit();
Event.observe(window, 'load', CE.registerAll, false);
Ajax.Responders.register(CE);
