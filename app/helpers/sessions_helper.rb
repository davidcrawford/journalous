module SessionsHelper
  def authenticate
    deny_access unless signed_in?
  end
  
  def sign_in(user)
    user.remember_me!
    cookies[:remember_token] = {  :value => user.remember_token,
                                  :expires => 20.years.from_now.utc }
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_basic_auth
    @current_user ||= user_from_remember_token
  end
  
  def user_from_remember_token
    remember_token = cookies[:remember_token]
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end
  
  def user_from_basic_auth
    if !self.respond_to?(:authenticate_with_http_basic)
      return false
    end
    authenticate_with_http_basic do |email, password|
      user = User.authenticate(email, password)
      self.sign_in user unless user.nil?
    end
  end
 
  def signed_in?
    !self.current_user.nil?
  end
  
  def sign_out
    cookies.delete :remember_token
    self.current_user = nil
  end

  def store_location
    session[:return_path] = request.referer
  end
  
  def redirect_back_or default
    redirect_to(session[:return_path] || default)
    session[:return_path] = nil
  end
  
  def deny_access
    if request.xhr?
      render :json => { :error => "You must be signed in." }.to_json, :status => 403
      return
    end
    respond_to do |format|
      format.html {
        flash[:error] = "Please sign in"
        redirect_to signin_path
      }
      format.json {
        render :json => { :error => "You must be signed in." }.to_json, :status => 403
      }
    end
  end
end
