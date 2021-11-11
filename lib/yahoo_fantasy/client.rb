# frozen_string_literal: true

require 'oauth2'

module YahooFantasy
  SITE = 'https://api.login.yahoo.com/'
  AUTHORIZE_URL = '/oauth2/request_auth'
  TOKEN_URL = '/oauth2/get_token'
  SCOPE = 'fspt-w,profile,email'

  # YahooFantasy::Client
  #
  # Provides some standarized (and opinionated) OAuth2::Client configuration with regards to the
  # Yahoo Fantasy API.  You're more than welcome to forgo using this - it can easily be reaplced
  # with a standard OAuth2::Client of your own configuration.
  # All the available OAuth2::Client options
  # are available (and will be ovewritten if provded); but the following defaults are
  # provided:
  # site: https://api.login.yahoo.com/
  # authorize_url: /oauth/request_aut
  # token_url: /oauth/get_token
  # redirect_url: oob
  #
  # For more information on the redirect (or just the Yahoo OAuth2 specification in general)
  # check out https://developer.yahoo.com/oauth2/guide/openid_connect/getting_started.html
  #
  # The Yahoo Client defaults to the following scopes:
  # - fspt-w (Fantasy Sports read/write).
  # - profile (Yahoo Profile)
  # - email (Yahoo Email)
  #
  # these scopes must match (completely) what you have configured in your Yahoo Developer App
  # configuration.  If these scopes don't match, your uses will get an error when attempting
  # to load the authorization url.
  #
  # @example
  #   client = YahooFantasy::Client.new('CLIENT_ID','CLIENT_SECRET',redirect_uri: 'https://redirect_uri.com/auth/yahoo')
  #   authorize_url = client.auth_code.authorize_url
  #
  #   # Apply and get token
  #   access_token = client.auth_code.get_token(code: 'result_code')
  #
  #   # Now apply the token
  #   YahooFantasy::Resource::Base.access_token = access_token
  #
  class Client < OAuth2::Client
    # Instantiates a new YahooFantasy::Client, passing through the client_id, client_secret,
    # options and block to the OAuth2::Client.
    def initialize(client_id, client_secret, options = {}, &block)
      yahoo_options = {
        site: SITE,
        authorize_url: AUTHORIZE_URL,
        token_url: TOKEN_URL,
        scope: SCOPE,
        redirect_uri: 'oob',
        connection_build: block
      }.merge!(options)
      super(client_id, client_secret, yahoo_options)
    end

    # Overrides OAuth2::Client#authorize_url ensuring that the application scope
    # is provide in the parameters.  Required Yahoo OAuth2 parameters are:
    # - scope
    #
    # If the provided scope doesn't match the authorize_url, the users will get an
    # error page stating that something went wrong (with not much else) which is
    # almost always non matching scope.
    def authorize_url(params = {})
      auth_params = {
        'scope' => options[:scope]
      }.merge!(params)
      super(auth_params)
    end
  end
end
