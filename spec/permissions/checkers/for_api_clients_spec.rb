require 'spec_helper'

RSpec.describe Permissions::Checkers::ForApiClients do
  let(:valid_jwt) do
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoiQXBpQ2xpZW50IiwibmFtZSI6IkZMSU1QRVItQkFDSyIsInBlcm1pc3Npb25zIjpbeyJuYW1lIjoiRkxJTVBFUi1CQUNLIiwicmVzb3VyY2VfY29kZSI6IlRXSVRURVJfQVBJX0JBQ0tFTkQiLCJsZXZlbCI6IldSSVRFIn1dfQ.iysEOSdu1xQUNjw_2ddyMcBzTxtpYcmgb8dT4X4M3Xk'
  end

  context 'when jwt is invalid' do
    it 'returns false' do
      expect(
        described_class.new(
          jwt_token: 'fake-token',
          resource_code: 'TWITTER-API',
          level: 'READ'
        ).can_perform_action?
      ).to eq(false)
    end
  end

  context 'when jwt is valid but api client has no permissions to perform action' do
    it 'returns false' do
      expect(
        described_class.new(
          jwt_token: valid_jwt,
          resource_code: 'TWITTER_API_BACKEND',
          level: 'READ'
        ).can_perform_action?
      ).to eq(false)
    end
  end

  context 'when jwt is valid and api client has permissions to perform action' do
    it 'returns true' do
      expect(
        described_class.new(
          jwt_token: valid_jwt,
          resource_code: 'TWITTER_API_BACKEND',
          level: 'WRITE'
        ).can_perform_action?
      ).to eq(true)
    end
  end
end
