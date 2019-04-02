require 'jwt'

module Permissions
  module Checkers
    class Template
      def can_perform_action?
        permissions.include?(permission_query) || permissions.include?(permission_query.merge('level' => 'ADMIN'))
      rescue JWT::DecodeError
        false
      end

      private

      def permissions
        decoded_jwt.dig('permissions') || []
      end

      def decoded_jwt
        @decoded_jwt ||= JWT.decode(jwt_token, ENV.fetch('PONCHO_API_SIGNATURE_KEY'), true, algorithm: 'HS256')[0]
      end

      def permission_query
        raise NotImplementedError
      end

      def jwt_token
        raise NotImplementedError
      end
    end
  end
end
