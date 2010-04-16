# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_interaje_meet_session',
  :secret      => '7ea7210ed35aa228dfad8ca3c287ddebe1c53ab5071cc84af61ba06fad49ac0e1d758dc68118deb1d946e65ff85e8e13bc4156551ca2db69453a0ed408bbb706'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
