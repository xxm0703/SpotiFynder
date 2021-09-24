require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:get]
  provider :spotify, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], scope: 'user-read-email user-top-read user-library-read'
end
