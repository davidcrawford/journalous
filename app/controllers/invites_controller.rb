class InvitesController < ApplicationController
  def new
    @title = "Send Invite"
  end

  def show
    @title = "Welcome"
    @invite = Invite.find_by_token(params[:id])
    @user = User.new
  end
  
  def create
    @invite = Invite.new(params[:invite])
    if @invite.save then
      redirect_to invite_show_path(@invite)
    else
      @title = "Send Invite"
      render 'new'
    end
  end
  
  def accept
    @invite = Invite.find_by_token(params[:id])
    @user = @invite.accept(params[:user][:password], params[:user][:password_confirmation])
    if @user.valid? then
      sign_in @user
      redirect_to root_path
    else
      @title = "Welcome"
      render 'show'
    end
  end
end
