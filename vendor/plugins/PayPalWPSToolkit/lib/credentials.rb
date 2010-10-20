
module PayPalWPSToolkit
  
  class Credentials  
    
    cattr_accessor :TARGET_TEST_ENV
    cattr_accessor :MY_BUSINESS_EMAIL_ADDRESS
    cattr_accessor :MY_BUSINESS_IDENTITY_TOKEN
    cattr_accessor :MY_BUSINESS_EWP_CERT
    cattr_accessor :MY_BUSINESS_EWP_KEY
    cattr_accessor :MY_BUSINESS_PRIVATE_KEY_PWD
    cattr_accessor :MY_BUSINESS_EWP_CERT_ID
    cattr_accessor :PAYPAL_CERT
    cattr_accessor :BUTTON_IMAGE    
    cattr_accessor :PAYPAL_CERTIFICATE_PATH
    cattr_accessor :plugin_cert_path
    cattr_accessor :TARGET_ENV
    cattr_accessor :MY_BUSINESS_EWP_CERT_PATH
    
    @@cert_path_root              = RAILS_ROOT+"/vendor/plugins/PayPalWPSToolkit/lib/cert"
    @@PAYPAL_CERTIFICATE_PATH     = "#{@@cert_path_root}/sandbox_cert_pem.txt"   
    @@MY_BUSINESS_EWP_CERT_PATH   = "#{@@cert_path_root}/my-pubcert.pem"
    @@PAYPAL_CERT                 = File::read(@@PAYPAL_CERTIFICATE_PATH)
    @@BUTTON_IMAGE                = 'https://www.paypal.com/en_US/i/btn/x-click-but23.gif'        
    @@MY_BUSINESS_PRIVATE_KEY_PWD = ''   
    @@MY_BUSINESS_EWP_CERT        = File::read(@@MY_BUSINESS_EWP_CERT_PATH)
    @@MY_BUSINESS_EWP_KEY         = File::read("#{@@cert_path_root}/my-prvkey.pem")   
    @@MY_BUSINESS_IDENTITY_TOKEN  = 'NAOoxKHaZaHTcR3PGckh_Abte1-1PRYQvlLYHYFBDGM-R93GHqjaHD8oVyy'     
    @@MY_BUSINESS_EMAIL_ADDRESS   = 'seller_1194378114_biz@zhengyi.ath.cx'    
    @@MY_BUSINESS_EWP_CERT_ID     = 'VVKKRMWWKUNR2'   
    @@MY_BUSINESS_EWP_CERT_ID     = 'Y697TNL8WZTD6'
    @@TARGET_TEST_ENV             = 'https://beta-sandbox.paypal.com/cgi-bin/webscr'  
    @@TARGET_ENV                  = 'beta-sandbox'
    
    
    #### Sandbox account ######
    # @@MY_BUSINESS_EWP_CERT_PATH   = "#{@@cert_path_root}/sdk-ewp-cert.pem"
    # @@MY_BUSINESS_PRIVATE_KEY_PWD = 'password' 
    # @@MY_BUSINESS_EWP_KEY         = File::read("#{@@cert_path_root}/sdk-ewp-key.pem")
    # @@MY_BUSINESS_IDENTITY_TOKEN  = 'G5JgcRdmlYUwnHcYSEXI2rFuQ5yv-Ei19fMFWn30aDkZAoKt_7LTuufYXUa'
    # @@MY_BUSINESS_EMAIL_ADDRESS   = 'sdk-seller@sdk.com'
    # @@MY_BUSINESS_EWP_CERT_ID     = 'KJAERUGBLVF6Y' 
    # @@TARGET_TEST_ENV             = 'https://sandbox.paypal.com/cgi-bin/webscr' 
    
  end
    
end