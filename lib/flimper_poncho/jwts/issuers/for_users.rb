require 'flimper_poncho/jwts/issuers/template'

module Jwts
  module Issuers
    class ForUsers < Jwts::Issuers::Template
      def initialize(email:, password:)
        @email = email
        @password = password
      end

      def poncho_api_endpoint
        "#{ENV.fetch('PONCHO_API_URL')}/users/jwt_tokens.json"
      end

      def security_data
        { email: @email, password: @password }.to_json
      end
    end
  end
end
