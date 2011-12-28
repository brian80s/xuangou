
var Navbars = {
  selected: function() {
    return $$(".on").first();
  },

  clear: function() {
    var selected = Navbars.selected();
    if (selected) selected.removeClassName("on");
  },
  
  select: function(element) {
    Navbars.clear();
    if($(element)) $(element).addClassName("on");
    //Cookie.set('admin_nav',element);    
  }
}
