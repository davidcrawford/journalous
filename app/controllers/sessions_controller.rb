class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def new
    @title = "Sign in"
    store_location unless request.referrer =~ /signup|signin|sessions/
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      # Error!
      flash.now[:error] = "Wrong email or password."
      @title = "Sign in"
      render 'new'
    else
      # Log 'em in
      sign_in user
      redirect_back_or home_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
