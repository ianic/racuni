# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_racuni_session',
  :secret      => '6a3013e45b9e0297d60d0a0e0af6c85ee904ca88c0938b5149b0c6243f9e725a6411d795f64d862846aeeacf3b3227d83bad81b2b70aa646d1f1bb00cc43f5d5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
