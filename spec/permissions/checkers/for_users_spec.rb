require 'spec_helper'

RSpec.describe Permissions::Checkers::ForUsers do
  let(:valid_jwt) do
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoiVXNlciIsImVtYWlsIjoiZW1haWwtMUBnbWFpbC5jb20iLCJwZXJtaXNzaW9ucyI6W3siZW1haWwiOiJlbWFpbC0xQGdtYWlsLmNvbSIsInJlc291cmNlX2NvZGUiOiJhcHBsaWNhdGlvbi0xIiwibGV2ZWwiOiJSRUFEIn1dfQ.MrWfT9Us6Xy_Ck8VySXZwnqhu7jp1HMToSwYPppPgTQ'
  end

  context 'when jwt is invalid' do
    it 'returns false' do
      expect(
        described_class.new(
          jwt_token: 'fake-token',
          resource_code: 'application-1',
          level: 'READ'
        ).can_perform_action?
      ).to eq(false)
    end
  end

  context 'when jwt is valid but user has no permissions to perform action' do
    it 'returns false' do
      expect(
        described_class.new(
          jwt_token: valid_jwt,
          resource_code: 'application-1',
          level: 'WRITE'
        ).can_perform_action?
      ).to eq(false)
    end
  end

  context 'when jwt is valid and user has permissions to perform action' do
    it 'returns true' do
      expect(
        described_class.new(
          jwt_token: valid_jwt,
          resource_code: 'application-1',
          level: 'READ'
        ).can_perform_action?
      ).to eq(true)
    end
  end

  context 'when jwt is valid and user has admin permissions to perform action' do
    let(:admin_jwt) do
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoiVXNlciIsImVtYWlsIjoiZW1haWwtMUBnbWFpbC5jb20iLCJwZXJtaXNzaW9ucyI6W3siZW1haWwiOiJlbWFpbC0xQGdtYWlsLmNvbSIsInJlc291cmNlX2NvZGUiOiJhcHBsaWNhdGlvbi0xIiwibGV2ZWwiOiJBRE1JTiJ9XX0.6V3siDsgV2DjDxGQ08GJ5nbwuKpAByk7BP05YHidGjA'
    end

    it 'returns true' do
      expect(
        described_class.new(
          jwt_token: admin_jwt,
          resource_code: 'application-1',
          level: 'READ'
        ).can_perform_action?
      ).to eq(true)
    end

    it 'returns true' do
      expect(
        described_class.new(
          jwt_token: admin_jwt,
          resource_code: 'application-1',
          level: 'WRITE'
        ).can_perform_action?
      ).to eq(true)
    end
  end
end
