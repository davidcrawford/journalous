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
end
