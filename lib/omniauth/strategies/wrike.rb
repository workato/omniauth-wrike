require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Wrike < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://www.wrike.com/api/v3/',
        :authorize_url => 'https://www.wrike.com/oauth2/authorize',
        :token_url => 'https://www.wrike.com/oauth2/token'
      }

      # def request_phase
      #   super
      # end

      # def authorize_params
        # super.tap do |params|
        #   %w[scope client_options].each do |v|
        #     if request.params[v]
        #       params[v.to_sym] = request.params[v]
        #     end
        #   end
        # end
      # end

      # uid { raw_info['uid'] }

      # info do
      #   {
      #     'nickname' => raw_info['login'],
      #     'email' => primary_email,
      #     'name' => raw_info['name'],
      #     'image' => raw_info['avatar_url'],
      #     'urls' => {
      #       'GitHub' => raw_info['html_url'],
      #       'Blog' => raw_info['blog'],
      #     },
      #   }
      # end

      # extra do
      #   {:raw_info => raw_info, :all_emails => emails}
      # end

      # def raw_info
      #   access_token.options[:mode] = :query
      #   @raw_info ||= access_token.get('user').parsed
      # end

      # def email
      #   (email_access_allowed?) ? primary_email : raw_info['email']
      # end

    end
  end
end