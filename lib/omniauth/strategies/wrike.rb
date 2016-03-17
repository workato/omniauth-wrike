require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Wrike < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://www.wrike.com/api/v3/',
        :authorize_url => 'https://www.wrike.com/oauth2/authorize',
        :token_url => 'https://www.wrike.com/oauth2/token'
      }

      uid { raw_info['id'] }

      info do
        {
          'uid' => raw_info['id'],
          'name' => raw_info['name']
        }
      end

      extra do
        { 
          'raw_info' => raw_info,
          'accounts' => accounts
        }
      end

      def raw_info
        @raw_info ||= first_account
      end

      def accounts
        @accounts ||= access_token.get('accounts').parsed['data']
      end

      def first_account
        @first_account ||= accounts.first
      end
    end
  end
end