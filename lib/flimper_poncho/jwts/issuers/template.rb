require 'faraday'
require 'json'

module Jwts
  module Issuers
    class Template
      def issue!
        poncho_response = Faraday.new.post do |request|
          request.url(poncho_api_endpoint)
          request.headers['Content-Type'] = 'application/json'
          request.body = security_data
        end

        return unless poncho_response.success?

        JSON.parse(poncho_response.body).dig('jwt_token')
      end

      private

      def poncho_api_endpoint
        raise NotImplementedError
      end

      def security_data
        raise NotImplementedError
      end
    end
  end
end
