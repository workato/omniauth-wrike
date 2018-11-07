require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Wrike < OmniAuth::Strategies::OAuth2
      option :name, 'wrike'

      option :client_options, {
        site: 'https://www.wrike.com/api/v4',
        authorize_url: 'https://www.wrike.com/oauth2/authorize/v4',
        token_url: 'https://www.wrike.com/oauth2/token'
      }

      uid { raw_info['id'] }

      info do
        {
          uid: raw_info['id'],
          name: "#{raw_info['firstName']} #{raw_info['lastName']}",
          email: user_email
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def user_email
        raw_info['profiles'].first['email']
      end

      def raw_info
        @raw_info ||= access_token.get('contacts?me=true').parsed['data'].first
      end
    end
  end
end
