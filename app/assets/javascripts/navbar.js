
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

/**
   * This section of code creates the collapsible control for the left
   * navigation. 
   */
  jQuery(function() {
    var pageContent = jQuery('#gc-pagecontent');
    var tableOfContents = jQuery('#gc-toc');
    
    if(pageContent.length) {
      /** 
       * Create a div to hold the arrow 
       * @type Object 
       */
      var cs_hoverArrow = jQuery('<div id="gc-collapsible-arrow">');

      /** 
       * Create a div to hold the collapsible column. 
       * @type Object 
       */
      var cs_collapsible = jQuery('<div id="gc-collapsible">');

      /**
       * Create a method we can use to calculate the arrow's location
       * based on mouse movements. This function is passed via a closure
       * to applied event methods below.
       *
       * @param {Event} eventObj used to poll the mouses y coordinate.
       */
      var hoverCalc = function(eventObj) {
        var offset = pageContent.offset();
        cs_hoverArrow.css({
          left: offset.left + 'px',
          top: (eventObj.pageY || eventObj.clientY) + 'px'
        });
      }

      // Add the collapsible and hoverArrow divs to the page.
      pageContent.css('position','relative').append(cs_collapsible);
      jQuery(document.body).append(cs_hoverArrow);
      
      // Adjust pageContent's location for IE6.... sigh
      if(jQuery.browser.msie && jQuery.browser.version < 7)
        pageContent.css('left','-5px');
        
      cs_collapsible.
        // When the mouse is over the collapsible, the hover class
        // is added thereby widening the background color, narrowing
        // the borders and if the nav is collapsed moving the bar 
        // right by its new visible width.
        mouseover(function(eventObj) {
          cs_collapsible.addClass('hover');
          if(tableOfContents.is(':hidden')) {
            cs_collapsible.css('left','-3px');
            cs_hoverArrow.addClass('collapsed');
          }
          else 
            cs_hoverArrow.removeClass('collapsed');
          cs_hoverArrow.show();
          hoverCalc(eventObj);          
        }).
        
        mousemove(function(eventObj) {
          hoverCalc(eventObj);
        }).
      
        // Undo the modifications of the mouse over effects. Remove the
        // hover class and reset the left to whatever values the style
        // sheet dictates regardless of the collapsed/expanded state
        mouseout(function() {
          cs_collapsible.removeClass('hover');
          cs_collapsible.css('left','');
          cs_hoverArrow.hide();
        }).
      
        // When clicked, remove any styling performed by mousing over
        // then toggle the visibility of the <div#gc-toc> div and 
        // restore the left margin's state on the pageContent div.
        click(function() {
          // Undo any mouseover/out states since the mouse will
          // have left the collapsible on the toc toggle. 
          cs_hoverArrow.hide();
          cs_collapsible.removeClass('hover').css('left','');
          tableOfContents.toggle();
          
          if(tableOfContents.is(':visible')) {
            pageContent.css('margin-left','');
            if(jQuery.browser.msie && jQuery.browser.version < 7)
              pageContent.css('left','-5px');
          }
          else {
            pageContent.css('margin-left','0px');
            if(jQuery.browser.msie && jQuery.browser.version < 7)
              pageContent.css('left','');
          }
        }).
        
        // Set the height of the collapsible to be the same height as the
        // pageContent div. 
        height(pageContent.height());        
    }    
  })