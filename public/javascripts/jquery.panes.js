(function($){
$.fn.panes = function(configOrCommand, arg) {
  var init = function(panes, config) {
    panes.each(function() {
      var $divs = $(this).children('div');
      var index = $.map($divs, function(div) {
        return $(div).attr('id');
      });
      var currentIndex = 0;
      
      $divs.each(function(i) { 
        if (i == 0) {
          $(this).addClass('panes-selected');
        }
        else {
          $(this).addClass('panes-hidden');
        }
      });
      
      $(this).data('index', $(index));
    });
  };

  var handleCommand = function(panes, command, arg) {
    panes.each(function() {
      if(command === 'select') {
        var $selectedPane = $(this).children('#' + arg);
        $(this).children('.panes-selected').fadeTo(350, 0.1, function() {
          $(this).addClass('panes-hidden').removeClass('panes-selected');
          $(this).css({'opacity': 1});
          $selectedPane.removeClass('panes-hidden').addClass('panes-selected');
          $('html, body').animate({scrollTop: $selectedPane.scrollTop()}, 'slow');
        });
      }
    });
  };
  
  if (typeof configOrCommand === 'string') {
    handleCommand($(this), configOrCommand, arg);
  }
  else {
    init($(this), configOrCommand);
  }
  
  return this;
};
})(jQuery);
