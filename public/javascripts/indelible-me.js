$(function() {
  
  // Prompt has `text`, `quote`, and `quote_author`
  window.Prompt = Backbone.Model.extend({});
  
  window.PromptList = Backbone.Collection.extend({
    model: Prompt,
    url: '/prompts'
  });
  
  window.Prompts = new PromptList;

  window.PromptView = Backbone.View.extend({

    tagName: "div",

    template: _.template(" \
      <div id='question'><%= text %></div> \
      <% if (quote) { %> \
        <blockquote> \
          <span id='quote'><%= quote %></span> \
          <figure id='arrow'></figure> \
          <% if (quote_author) { %> \
            <div id='author'><%= quote_author %></div> \
          <% } %> \
        </blockquote> \
      <% } %>"),
    
    initialize: function() {
      _.bindAll(this, 'render');
      this.bind('change:model', this.render);
      this.render();
    },
    
    render: function() {
      $(this.el).html(this.template(this.model.get('prompt')));
      return this;
    }
  });
  
  window.PromptListView = Backbone.View.extend({

    el: $("#prompts"),

    events: {
      "click #next-button": "showNext",
      "click #previous-button": "showPrevious",
      "click #answer-button": "showAnswerBox"
    },

    hasNext: function() { return (this.index + 1 < Prompts.length); },

    hasPrevious: function() { return (this.index > 0); },

    itemEl: $("#prompt"),

    initialize: function() {
      _.bindAll("hasNext", "hasPrevious", "updateButtons", "showNext", "showPrevious", "showIndex", "showAnswerBox", "render");
      this.index = 0;
    },

    showAnswerBox: function() {
    },

    render: function() {
      this.updateButtons();
      var view = new PromptView({model: Prompts.at(this.index)});
      var itemEl = this.itemEl;
      itemEl.fadeOut(325, function() {
        itemEl.html(view.render().el);
        itemEl.fadeIn(325);
      });
    },

    showNext: function() {
      if (!this.hasNext()) return;
      this.index++;
      this.render(); 
    },

    showPrevious: function() {
      if (!this.hasPrevious()) return;
      this.index--;
      this.render(); 
    },

    updateButtons: function() {
      if (this.hasNext()) {
        $("#next-button").show().removeAttr("disabled");
      }
      else {
        $("#next-button").attr("disabled","disabled");
      }
      
      if (this.hasPrevious()) {
        $("#previous-button").show().removeAttr("disabled");
      }
      else {
        $("#previous-button").attr("disabled","disabled");
      }
    }
  });

  window.App = new PromptListView;
});
