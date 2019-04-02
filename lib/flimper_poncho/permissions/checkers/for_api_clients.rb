require 'flimper_poncho/permissions/checkers/template'

module Permissions
  module Checkers
    class ForApiClients < Permissions::Checkers::Template
      attr_reader :jwt_token

      def initialize(jwt_token:, resource_code:, level:, name:)
        @jwt_token = jwt_token
        @resource_code = resource_code
        @level = level
        @name = name
      end

      def permission_query
        { 'name' => @name, 'resource_code' => @resource_code, 'level' => @level }
      end
    end
  end
end
