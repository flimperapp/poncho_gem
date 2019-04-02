require 'spec_helper'

RSpec.describe Jwts::Issuers::ForUsers do
  describe '#issue!' do
    context 'when credentials are wrong' do
      let(:jwt_issuer) { described_class.new(email: 'test@test.com', password: 'fake-one') }

      it 'returns nil' do
        VCR.use_cassette 'users/jwt_tokens/wrong_credentials' do
          expect(jwt_issuer.issue!).to be_nil
        end
      end
    end

    context 'when credentials are valid ones' do
      let(:jwt_issuer) { described_class.new(email: 'test@test.com', password: 'password') }

      it 'returns a valid JWT' do
        VCR.use_cassette 'users/jwt_tokens/valid_credentials' do
          expect(jwt_issuer.issue!).to_not be_nil
        end
      end
    end
  end
end
