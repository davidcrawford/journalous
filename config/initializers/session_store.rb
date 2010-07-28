# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_journalous_session',
  :secret      => '461087ab04600360d3e2a4e16f0c262dafdc68ea8257d9ae337590c8a58d8a0754086aedbb585cedd68bb84ffa7d504aac1f089d3e79a9dc0add9b6af49dd289'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
