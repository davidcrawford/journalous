class InvitesController < ApplicationController
  def new
    @title = "Send Invite"
  end

  def show
    @title = "Welcome"
    @invite = Invite.find(params[:id])
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
    @user = User.new(params[:user])
    if @user.save then
      sign_in @user
      redirect_to root_path
    else
      @title = "Welcome"
      @invite = Invite.find(params[:id])
      render 'show'
    end
  end
end
