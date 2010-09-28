require 'twiliolib'

# Twilio REST API version
API_VERSION = '2010-04-01'

# Twilio AccountSid and AuthToken
ACCOUNT_SID = 'AC091f088c6576aafbbc591b686a4c2dc2'
ACCOUNT_TOKEN = 'a508cf303b1401cff772e009024a2e51'

# Outgoing Caller ID previously validated with Twilio
CALLER_ID = '3016413601';

class TwizzleController < ApplicationController
  
  def test
    # Create a Twilio REST account object using your Twilio account ID and token
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)

    d = {
        'From' => CALLER_ID,
        'To' => '301-641-3601',
        'Url' => 'http://memoirable.heroku.com/twizzle/call',
        'IfMachine' => 'Hangup',
        'Timeout' => '20',
        'StatusCallback' => 'http://memoirable.heroku.com/twizzle/endcall'
    }
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/Calls",
        'POST', d)
    resp.error! unless resp.kind_of? Net::HTTPSuccess
    render :text => "code: %s\nbody: %s" % [resp.code, resp.body]
    return
  end    
  
  def call
    render :text => "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<Response><Say>Hi there.  Eat my dust!</Say><Hangup/></Response>"
    return
  end
  
  def endcall
    log = File.open("log/calls.log", "a")
    log.puts "To: " + params[:To]
    log.puts "From: " + params[:From]
    log.puts "CallStatus: " + params[:CallStatus]
    log.puts "-----------"
    log.close
    render :text => "Done"
    return
  end
end
