class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def list
    @title = "Home"
    @prompts = Prompt.all
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
end
