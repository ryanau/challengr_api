# require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class JsonWebToken < Authenticatable
      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        return fail! unless claims
        return fail! unless claims.has_key?('uid')

        success! User.find_by_uid claims['uid']
      end

      protected

      def claims
        strategy, token = request.headers['Authorization'].split(' ')
        return nil if (strategy || '').downcase != 'bearer'
        JWTWrapper.decode(token)
      end
    end
  end
end
