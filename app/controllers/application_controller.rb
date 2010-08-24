# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include SessionsHelper
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout proc{ |c| c.request.xhr? ? false : "application" }

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
end
