(function($){
$.fn.autosubmit = function(config) {
  var Queue = (function() {
    var q = [];
    var push = function(func) {
      if (typeof func !== 'function') return;
      
      q.push(function() {
        func();
        q.shift();
        if (q.length) q[0]();
      });
      
      if(q.length == 1) {
        setTimeout(q[0], 1);
      }
    };
    
    return {
      push: push
    };
  })();
  
  return this.each(function() {

    var config = $.extend(config, {
      intervalMillis: 3000
    });
    var form = $(this).parents('form');
    var timer = null;
    var startTimer = function() {
      if (timer) clearTimeout(timer);
      timer = setTimeout(function() {
        Queue.push(function() { form.submit(); });
      }, config.intervalMillis);
    };
    
    $(this).unbind('.autosubmit')
      .bind('keyup.autosubmit', startTimer)
      .bind('keydown.autosubmit', startTimer)
      .bind('change.autosubmit', startTimer)
  });  
}
})(jQuery);
