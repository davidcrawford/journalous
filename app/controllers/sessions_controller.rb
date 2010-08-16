class SessionsController < ApplicationController
  def new
    @title = "Sign in"
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
      redirect_to home_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
