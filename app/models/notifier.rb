class Notifier < ActionMailer::Base
  
  def request_received(invite_request)
    recipients  invite_request.email
    from        "david@indelible.me"
    subject     "Thanks from Indelible.me"
  end
  
  def account_created(user)
    @user = user
    recipients  user.email
    from        "david@indelible.me"
    subject     "Your new indelible.me account"
  end
end
