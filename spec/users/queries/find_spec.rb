require 'spec_helper'

RSpec.describe FlimperPoncho::Users::Queries::Find do
  let(:user_jwt) do
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoiVXNlciIsImlkIjo3LCJlbWFpbCI6Im1hcmNlbEBmbGltcGVyLmNvbSIsInBlcm1pc3Npb25zIjpbeyJlbWFpbCI6Im1hcmNlbEBmbGltcGVyLmNvbSIsInJlc291cmNlX2NvZGUiOiJOSUtJVEFfQVBJX0FETUlOX1BBTkVMIiwibGV2ZWwiOiJBRE1JTiJ9XX0.Skh9_T5xb-ReaqRo186Ez2i0zGLbQhBRWpAvnfNHNZs'
  end

  it 'returns the right data' do
    result = described_class.new(jwt_token: user_jwt).run

    expect(result.email).to eq('marcel@flimper.com')
    expect(result.id).to eq(7)
    expect(result.permissions).to be_an Array
  end
end
