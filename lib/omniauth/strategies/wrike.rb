require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Wrike < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://www.wrike.com/api/v3/',
        :authorize_url => 'https://www.wrike.com/oauth2/authorize',
        :token_url => 'https://www.wrike.com/oauth2/token'
      }

      # def authorize_params
        # super.tap do |params|
        #   %w[scope client_options].each do |v|
        #     if request.params[v]
        #       params[v.to_sym] = request.params[v]
        #     end
        #   end
        # end
      # end

      uid { raw_info['id'] }

      info do
        {
          'uid' => raw_info['id'],
          'name' => raw_info['name'],
          'email' => nil,
          'image' => nil
        }
      end

      def raw_info
        @raw_info ||= default_account
      end

      def accounts
        @accounts ||= access_token.get('/accounts').parsed['data']
      end

      def default_account
        @default_account ||= accounts.first
      end

      # def email
      #   (email_access_allowed?) ? primary_email : raw_info['email']
      # end

    end
  end
end