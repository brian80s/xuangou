/* 
Document   : edit_tabs
Created on : 2007-12-26, 11:44:32
Author     : yj
Description:
include 'edit_tabs.js'
include 'edit_tabs.css'
*/
/*-------------------------------------------------
EDIT TABS
-------------------------------------------------*/
var EditTabs = {
  selectOnLoad: function() {
    if (location.hash) { 
      var id = location.hash.substr(1);
      EditTabs.select(id + '_link', id + '_tab');
    }
  },
  
  selected: function() {
    return $$(".current_edit_tab").first();
  },
  
  currently_visible: function() {
    return $$(".visible_edit_tab").first();
  },
  
  clear: function() {
    var selected = EditTabs.selected();
    var visible = EditTabs.currently_visible();
    if (selected) selected.removeClassName("current_edit_tab");
    if (visible) {
      Element.hide(visible);
      visible.removeClassName("visible_edit_tab");
    }
  },
  
  select: function(element, element_to_show) {
    EditTabs.clear();
    $(element).addClassName("current_edit_tab");
    $(element_to_show).addClassName("visible_edit_tab");
    Element.show(element_to_show);
  },
  
  clearBlanks: function() {
    $$('.blank').each(function(i) { 
      if(navigator.userAgent.match(/Safari/) && i.tagName == "TEXTAREA") {
        i.innerHTML = '';
      } else {
      i.value = '';
    }
  })
}
}
