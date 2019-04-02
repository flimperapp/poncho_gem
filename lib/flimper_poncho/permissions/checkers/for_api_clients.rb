require 'flimper_poncho/permissions/checkers/template'

module Permissions
  module Checkers
    class ForApiClients < Permissions::Checkers::Template
      attr_reader :jwt_token

      def initialize(jwt_token:, resource_code:, level:)
        @jwt_token = jwt_token
        @resource_code = resource_code
        @level = level
      end

      def permission_query
        { 'name' => decoded_jwt.dig('name'), 'resource_code' => @resource_code, 'level' => @level }
      end
    end
  end
end
