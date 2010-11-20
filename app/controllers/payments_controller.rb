class PaymentsController < ApplicationController
  include ActiveMerchant::Billing
  
  def checkout
    setup_response = gateway.setup_purchase(2500,
      :ip => request.remote_ip,
      :return_url => url_for(:action => 'confirm', :only_path => false),
      :cancel_return_url => url_for(:controller => 'users', :action => 'new', :only_path => false)
    )
    redirect_to gateway.redirect_url_for(setup_response.token)
  end

  def confirm
    if !params[:token]
      redirect_to url_for(:signup)
      return
    end
    
    details_response = gateway.details_for(params[:token])
    
#    if !details_response.success?
#      @message = details_response.message
#      render :action => 'error'
#      return
#    end
    
    @address = details_response.address
    @email = details_response.email
    @name = details_response.name
  end

  def complete
    purchase = gateway.purchase(2500,
      :ip => request.remote_ip,
      :payer_id => params[:payer_id],
      :token => params[:token]
    )
    
    if !purchase.success?
      @message = purchase.message
      render :action => 'error'
      return
    end
    
    @transaction_id = purchase.params['transaction_id']
    
    @user = User.new({ :name => params[:name],
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password],
      :paypal_transaction_id => @transaction_id
    })
    
    if @user.save
      Notifier.deliver_account_created(@user)
      sign_in @user
      redirect_to :controller => 'prompts', :action => 'index'
    else
      @message = "There was an error creating your account.  Please contact david@indelible.me to get this sorted out.  Sorry!"
      render :action => 'error'
    end
  end
  
  private
  def gateway
    @gateway ||= PaypalExpressGateway.new(
      :login => 'sell1_1289691878_biz_api1.minetowin.com',
      :password => '1289691887',
      :signature => 'AlnhS38RG3ELynQqUFkcFDobYejcA3e2JG95LVqUpxZbdMz577vhTmve'
    )
  end

end
