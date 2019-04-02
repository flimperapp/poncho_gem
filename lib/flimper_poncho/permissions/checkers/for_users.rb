require 'flimper_poncho/permissions/checkers/template'

module Permissions
  module Checkers
    class ForUsers < Permissions::Checkers::Template
      attr_reader :jwt_token

      def initialize(jwt_token:, resource_code:, level:, email:)
        @jwt_token = jwt_token
        @resource_code = resource_code
        @level = level
        @email = email
      end

      def permission_query
        { 'email' => @email, 'resource_code' => @resource_code, 'level' => @level }
      end
    end
  end
end
