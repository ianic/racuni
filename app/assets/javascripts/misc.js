// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var Placeolder = {
  
  create: function(id, parent_id)
  {
    var parent = $(parent_id);
    var div = document.createElement("div");
    div.id = id;
    var img = document.createElement("img");
    img.src = "/assets/indicator.gif";
    div.appendChild(img);
    parent.appendChild(div);
  },
  
  hideAllChilds: function(parent_id)
  {   
    var parent = $(parent_id);
    for(i=0; i<parent.childNodes.length; i++)
      try
        { 
          if (Element.visible(parent.childNodes[i]))
            Element.hide(parent.childNodes[i]);
            }
      catch(e)
        {}
  },
  
  show: function(id, parent_id)
  {
    var parent = $(parent_id);              
    this.hideAllChilds(parent);
    element = $(id);
    if (element)
      {
        Element.show(element);
          return true;
            }
    else
      {
        this.create(id, parent_id);
        return false;
      }               
  },
  
  showIndicator: function(id)
  {
    var element = $(id);
    element.innerHTML = "";
    var img = document.createElement("img");
    img.src = "/assets/indicator.gif";
    element.appendChild(img);
    Element.show(element);
  }
  
};

var InPlaceEditor = Class.create();
InPlaceEditor.prototype = {
  
  setOptions: function(options) {
    this.options = {
      hideView:    true,
      defaultEdit: false,
      fieldToFocus: null
    }
    Object.extend(this.options, options || {});
  },
  
  initialize: function(viewElement, editElement, options) 
  {
    this.setOptions(options);
    this.editElement = $(editElement).id;
    this.viewElement = $(viewElement).id;
    Element.hide(this.editElement);
    Element.show(this.viewElement);
    this.bind();  
    if (this.options.defaultEdit)
      this.toggle();
  },
  
  bind: function(){
    this.oldBackground = $(this.viewElement).style.backgroundColor; 
    $(this.viewElement).title = "Kliknite za izmjene";
    $(this.editElement).style.backgroundColor = "#f6f6f6";
    $(this.viewElement).onclick = this.toggle.bindAsEventListener(this);   
    $(this.viewElement).onmouseover = this.enterHover.bindAsEventListener(this);   
    $(this.viewElement).onmouseout = this.leaveHover.bindAsEventListener(this); 
  },
  
  enterHover: function() {
    $(this.viewElement).style.backgroundColor = "#FFFF99";
  },
  
  leaveHover: function() {
    $(this.viewElement).style.backgroundColor = this.oldBackground;
  },
  
  toggle: function()
  {
    if (this.options.hideView)
      {
        Element.toggle(this.editElement);
        Element.toggle(this.viewElement);
      }
    else
      Element.toggle(this.editElement);
    if (this.options.fieldToFocus != null)
      {
        Field.focus(this.options.fieldToFocus);
          Field.select(this.options.fieldToFocus);
            }
  }
  
};


var InPlaceAjaxEditor = Class.create();
InPlaceAjaxEditor.prototype = {
  initialize: function(viewElement, action)
  {
    this.action = action;
    if ($(viewElement) != null)
      {
        this.viewElement = $(viewElement);
        this.oldBackground = this.viewElement.style.backgroundColor;
        this.viewElement.title = "Kliknite za izmjene";
        this.viewElement.onclick = this.onclick.bindAsEventListener(this);
        this.viewElement.onmouseover = this.enterHover.bindAsEventListener(this);
        this.viewElement.onmouseout = this.leaveHover.bindAsEventListener(this);
        this.viewElement.style.cursor = "pointer";
      }
  },

  enterHover: function() {
    this.viewElement.style.backgroundColor = "#FFFF99";
  },

  leaveHover: function() {
    this.viewElement.style.backgroundColor = this.oldBackground;
  },

  onclick: function()
  {
    this.createEditor();
    this.fillEditor(this.showEditor);
  },

  show: function()
  {
    this.createEditor();
    this.fillEditor(this.showEditor);
  },

  createEditor: function()
  {
    if ($('edit') == null)
      {
        var edit = document.createElement("div");
        edit.id = 'edit';
        $('body').appendChild(edit);
        Element.hide('edit');
      }
  },

  fillEditor: function(f)
  {
    new Ajax.Updater('edit', this.action, { asynchronous: true, evalScripts: true, onComplete: function(request) { f(); }});
  },

  showEditor: function()
  {
    if (editor_window == null)
      {
        editor_window = new Window('editor_window', {className: "alphacube", showEffect: Element.show, hideEffect: Element.hide, minimizable: false, maximizable: false});
        editor_window.setDestroyOnClose()
        editor_window.setContent('edit', true, false);
        editor_window.showCenter();

        editor_window_observer = { onDestroy:
                                   function(eventName, win)
                                   {
                                     if (win == editor_window)
                                       {
                                         editor_window = null;
                                         Windows.removeObserver(this);
                                         Element.hide('edit');
                                       }
                                   }
        }
        Windows.addObserver(editor_window_observer);
      }
    new Effect.Highlight('editor_window');
  }
};

var editor_window;

TabControl = function(control_id, options) {
  var id = "#" + control_id;
  $$(id+' ul.tabs li a').each(function(a) {
      var page = a.getAttribute('href').match(/[-_\w]+$/i)[0];
        
        showPage = function(a, page)
          {
            $(a.parentNode).addClassName('active');
            $(page).show();
          }
          
          if (page != options['current']) { $(page).hide() } 
          else { showPage(a, page) }
            
            Event.observe(a, 'click', function(e) {
                $$(id+' ul.tabs li.active').each(function(e) { e.removeClassName('active'); })
                  $$(id+' .tab_page[id!='+page+']').each(function(e) { e.hide() });
                  showPage(a, page);
                    Event.stop(e);
                      });
              });
}


function toggleSidebar()
{
  if (sidebarHidden())
    Element.removeClassName(document.body, 'hide-sidebar');
  else
    Element.addClassName(document.body, 'hide-sidebar');

  new Ajax.Request('/user/sidebar?hidden=' + (sidebarHidden() ? '1' : '0'), {asynchronous:true, evalScripts:true});
}

function sidebarHidden()
{
  return Element.hasClassName(document.body, 'hide-sidebar');
}
