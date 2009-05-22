# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_meftos.com_session',
  :secret      => '5558c00798bbfc7b33b2a5d5d0dbf1d15ce25205266f4cd83eecf71fd8e913ef0c3e4b04fa52329dac91633e2dc1723090d16b38528ca63bc8e13347c4f883d1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
