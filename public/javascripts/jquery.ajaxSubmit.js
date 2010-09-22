(function($){
$.fn.ajaxSubmit = function(config) {
  var form = (this.is('form')) ? this : this.parents('form');
  
  $.ajax({
    beforeSend: function(request) {
      form.find('.spinny').show();
    },
    complete: function(request, status) {
      form.find('.spinny').hide();
    },
    data: form.serialize(),
    error: config.error,
    success: config.success,
    type: 'POST',
    url: form.attr('action')
  });
  
  return this;
}
})(jQuery);
