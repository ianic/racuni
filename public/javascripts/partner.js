function ShowAdresarStranica(page)
{
  link = $("adresar_stranica_link_" + page)	  
	id = 'adresar_stranica_' +  page;
	//napuni aktivni tab		
	Placeolder.show(id, 'adresar_content');
		new Ajax.Updater(id, '/partner/page/?page=' + page, 
  		{asynchronous:true, evalScripts:true}); 
  //sakrij - prikaži aktivni tab
  e = document.getElementsByClassName("current_tab", $("tabs"));			  
  Element.addClassName(link, "current_tab");
  if (e.length > 0)
    Element.removeClassName(e[0], "current_tab");
}