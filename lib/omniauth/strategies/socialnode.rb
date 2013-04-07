require 'omniauth-oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Socialnode < OmniAuth::Strategies::OAuth
      
      option :name, 'socialnode'

      option :client_options, {
        :access_token_path => "/api/oauth/access_token",
        :authorize_path => "/api/oauth/authorize",
        :request_token_path => "/api/oauth/request_token",
        :site => "http://socialno.de"
      }

      uid { 
        access_token.params[:id] 
      }
      attr_reader :access_token

           info do
        {
          :nickname => raw_info['screen_name'],
          :name => raw_info['name'],
          :location => raw_info['location'],
          :image => options[:secure_image_url] ? raw_info['profile_image_url_https'] : raw_info['profile_image_url'],
          :description => raw_info['description'],
          :urls => {
            'Website' => raw_info['url'],
            'Socialnode' => "http://socialno.de/#{raw_info['screen_name']}",
          }
        }
      end

      extra do
        { :raw_info => raw_info }
      end

        def raw_info 
          p "raw_info access_token.params: #{access_token.params}"
        @raw_info ||= MultiJson.load(access_token.get('/api/account/verify_credentials.json').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      alias :old_request_phase :request_phase

      def request_phase
        force_login = session['omniauth.params'] ? session['omniauth.params']['force_login'] : nil
        screen_name = session['omniauth.params'] ? session['omniauth.params']['screen_name'] : nil
        x_auth_access_type = session['omniauth.params'] ? session['omniauth.params']['x_auth_access_type'] : nil
        if force_login && !force_login.empty?
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:force_login => 'true')
        end
        if screen_name && !screen_name.empty?
          options[:authorize_params] ||= {}
          options[:authorize_params].merge!(:force_login => 'true', :screen_name => screen_name)
        end
        if x_auth_access_type
          options[:request_params] ||= {}
          options[:request_params].merge!(:x_auth_access_type => x_auth_access_type)
        end

        if session['omniauth.params'] && session['omniauth.params']["use_authorize"] == "true"
          options.client_options.authorize_path = '/api/oauth/authorize'
        else
          options.client_options.authorize_path = '/api/oauth/authorize'
        end

        old_request_phase
      end

      
     

      
    end
  end
end


