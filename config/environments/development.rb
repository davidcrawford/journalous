# Settings specified here will take precedence over those in config/environment.rb
require "active_merchant"

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

# Add paypal sandbox creds
config.paypal_gateway.login = 'sell1_1289691878_biz_api1.minetowin.com'
config.paypal_gateway.password = '1289691887'
config.paypal_gateway.signature = 'AlnhS38RG3ELynQqUFkcFDobYejcA3e2JG95LVqUpxZbdMz577vhTmve'

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
end
