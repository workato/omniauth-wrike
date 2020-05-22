require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Wrike < OmniAuth::Strategies::OAuth2
      option :name, 'wrike'

      option :client_options,
             site: 'https://www.wrike.com/api/v4',
             authorize_url: 'https://www.login.wrike.com/oauth2/authorize/v4',
             token_url: 'https://www.login.wrike.com/oauth2/token'

      uid { user_id }

      info do
        {
          uid: user_id,
          name: user_name,
          email: user_email
        }
      end

      extra do
        {
          raw_info: raw_info,
          account_info: account_info
        }
      end

      def user_email
        raw_info['profiles'].first['email']
      end

      def user_name
        [raw_info['firstName'], raw_info['lastName']].join(' ')
      end

      def user_id
        [account_info['id'], raw_info['id']].join(':')
      end

      def user_data_url
        @user_data_url ||= URI::HTTPS.build(
          host: access_token.params['host'],
          path: '/api/v4/contacts',
          query: 'me=true'
        ).to_s
      end

      def user_account_url
        @user_account_url ||= URI::HTTPS.build(
          host: access_token.params['host'],
          path: '/api/v4/account'
        ).to_s
      end

      def account_info
        @account_info ||= access_token.get(user_account_url).parsed['data'].first
      end

      def raw_info
        @raw_info ||= access_token.get(user_data_url).parsed['data'].first
      end
    end
  end
end
