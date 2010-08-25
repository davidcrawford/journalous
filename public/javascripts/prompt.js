var Prompt = (function() {
  var begin_answer = function(prompt_id, question, answer) {
    $('#answer-pane .question').text(question);
    $('#answer-pane form').attr('action', '/prompts/' + prompt_id + '/answer');
    if (answer) {
      $('#answer-pane textarea').text(answer);
    }
    else {
      $('#answer-pane textarea').text('Tell your story here...');
    }
    $('#panes').panes('select', 'answer-pane');
  };
  
  var submit_answer = function(submit_button) {
    submit_button.ajaxSubmit({
      success: function() {
        $('#answer-pane .status').html('Saved').show();
        $('#list-pane').load('/prompts/list');
      },
      error: function() {
        $('#answer-pane .status').html('Error').show();
      }
    });
    return false;
  };
  
  return {
    begin_answer: begin_answer,
    submit_answer: submit_answer
  };
})();
