# require 'B62'

class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @title = "Sign up"
    @user = User.new
  end

  def create
    password = generate_password
    @user = User.new(params[:user].merge({
          :password => password,
          :password_confirmation => password
    }))
    if @user.save
      # Handle success
      # Log the user in
      redirect_to :controller => 'pages', :action => 'list'
    else
      @title = "Sign up"
      render 'new'
    end
  end

  private
    
    def generate_password
       pass = B62.encode(rand(10000000000) + 100000000)
       return pass
    end
end

