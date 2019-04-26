module FlimperPoncho
  module Users
    module Queries
      class Find
        def initialize(jwt_token:)
          @jwt_token = jwt_token
        end

        def run
          OpenStruct.new(id: decoded_jwt['id'], email: decoded_jwt['email'], permissions: permissions)
        end

        private

        def decoded_jwt
          @decoded_jwt ||= JWT.decode(@jwt_token, ENV.fetch('PONCHO_API_SIGNATURE_KEY'), true, algorithm: 'HS256')[0]
        end

        def permissions
          @permissions ||= decoded_jwt.dig('permissions').map do |perm|
            OpenStruct.new(email: perm['email'], resource_code: perm['resource_code'], level: perm['level'])
          end
        end
      end
    end
  end
end
