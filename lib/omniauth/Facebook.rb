require 'httparty'

module Omniauth
  class Facebook
    include HTTParty

    base_uri 'https://graph.facebook.com/v2.8'

    def self.authenticate(code)
      provider = self.new
      access_token = provider.get_access_token(code)
      user_info = provider.get_user_profile(access_token)
      return user_info, access_token
    end

    def self.deauthorize(access_token)
      options = { query: { access_token: access_token } }
      response = self.delete('/me/permissions', options)

      unless response.success?
        Rails.logger.error('Omniauth::Facebook.deauthorize Failed...')
        raise Omniauth::ResponseError, 'errors.auth.facebook.deauthorization'
      end
      response.parsed_response
    end

    def get_access_token(code)
      response = self.class.get('/oauth/access_token', query(code))
      unless response.success?
        Rails.logger.error('Omniauth::Facebook.get_access_token Failed...')
        raise Omniauth::ResponseError, 'errors.auth.facebook.access_token'
      end
      response.parsed_response['access_token']
    end

    def get_user_profile(access_token)
      options = { query: { access_token: access_token } }
      response = self.class.get('/me', options)
      uid = response.parsed_response['id']
      r = self.class.get("/#{uid}", { query: { access_token: access_token, fields: 'id, email, first_name, last_name' } } )

      unless response.success?
        Rails.logger.error('Omniauth::Facebook.get_user_profile Failed...')
        raise Omniauth::ResponseError, 'errors.auth.facebook.user_profile'
      end
      r.parsed_response['access_token'] = access_token
      r.parsed_response
    end

    private

    def query(code)
      {
        query: {
          code: code,
          redirect_uri: 'http://localhost:8080/auth/callback',
          client_id: ENV['FACEBOOK_APP_ID'],
          client_secret: ENV['FACEBOOK_APP_SECRET']
        }
      }
    end
  end
end

