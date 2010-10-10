class UsersController < ApplicationController
  before_filter :authenticate, :only => [ :show, :answers ]

  def show
    @user = User.find(params[:id])
  end

  def new
    @title = "Sign up"
    @user = User.new
  end
  
  def email
    @inv = InviteRequest.new({ :email => params[:email], :response_sent => true })
    
    if @inv.save
      Notifier.deliver_request_received(@inv)
      render :json => { :status => "success" }
    else
      render  :json => { :status => "error" },
              :status => 400
    end
    return
  end

  def create
    password = generate_password
    @user = User.new(params[:user].merge({
          :password => password,
          :password_confirmation => password
    }))
    if @user.save
      # Handle success
      # Send password
      Email.send params[:user][:email], :from => "notify@memoirable.com",
                                        :subject => "Welcome to memoirable!",
                                        :body => "Thanks for joining!  Here's your password: #{password}"
      
      sign_in @user
      redirect_to :controller => 'pages', :action => 'list'
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def answers
    @user = User.find(params[:id])
  end

  private
    
    def generate_password
       pass = B62.encode(rand(10000000000) + 100000000)
       return pass
    end
end

