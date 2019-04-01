require 'active_interaction'
require 'faraday'
require 'json'
require 'flimper_poncho/entities/user_session'

module FlimperPoncho
  module UserSession
    class Create < ActiveInteraction::Base
      string :email
      string :password

      validates :email, :password, presence: true

      def execute
        poncho_response = faraday_connection.post do |request|
          request.url(poncho_api_url)
          request.headers['Content-Type'] = 'application/json'
          request.body = { email: email, password: password }.to_json
        end

        return unless poncho_response.success?

        FlimperPoncho::Entities::UserSession.new(jwt: JSON.parse(poncho_response.body).dig('jwt_token'))
      rescue KeyError => error
        errors.add(:poncho_api_url, error.message)
      end

      private

      def poncho_api_url
        @poncho_api_url ||= "#{ENV.fetch('PONCHO_API_URL')}/user_sessions"
      end

      def faraday_connection
        @faraday_connection ||= Faraday.new
      end
    end
  end
end
