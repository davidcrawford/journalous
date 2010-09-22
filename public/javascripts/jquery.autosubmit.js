(function($){
$.fn.autosubmit = function(config) {
  return this.each(function() {

    var config = $.extend(config, {
      intervalMillis: 750
    });
    var form = $(this).parents('form');
    var timer = null;
    var startTimer = function() {
      if (timer) clearTimeout(timer);
      timer = setTimeout(function() {
        form.submit();
      }, config.intervalMillis);
    };
    
    $(this).unbind('.autosubmit')
      .bind('keyup.autosubmit', startTimer)
      .bind('keydown.autosubmit', startTimer)
      .bind('change.autosubmit', startTimer)
  });  
}
})(jQuery);
