require 'jwt'

module FlimperPoncho
  module Entities
    class UserSession
      attr_reader :email, :authorization_token, :permissions

      def initialize(jwt:)
        @jwt = jwt
        @authorization_token = jwt_decode.dig('authorization_token')
        @email = jwt_decode.dig('email')

        @permissions = jwt_decode.dig('permissions').map do |permission|
          { email: permission.dig('email'), resource_code: permission.dig('resource_code'),
            level: permission.dig('level') }
        end
      end

      private

      def jwt_decode
        @jwt_decode ||= JWT.decode(@jwt, ENV.fetch('PONCHO_API_SIGNATURE_KEY'), true, algorithm: 'HS256')[0]
      end
    end
  end
end
