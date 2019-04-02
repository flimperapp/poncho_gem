require 'flimper_poncho/jwts/issuers/template'

module Jwts
  module Issuers
    class ForApiClients < Jwts::Issuers::Template
      def initialize(name:, authorization_token:)
        @name = name
        @authorization_token = authorization_token
      end

      def poncho_api_endpoint
        "#{ENV.fetch('PONCHO_API_URL')}/api_clients/jwt_tokens.json"
      end

      def security_data
        { name: @name, authorization_token: @authorization_token }.to_json
      end
    end
  end
end
