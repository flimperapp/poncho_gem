RSpec.describe FlimperPoncho::UserSession::Create do
  context 'without email' do
    subject { described_class.run(password: 'test') }

    it { is_expected.to_not be_valid }
  end

  context 'with out password' do
    subject { described_class.run(email: 'test@test.com') }

    it { is_expected.to_not be_valid }
  end

  context 'when email and password are wrong' do
    before do
      stub_request(:post, 'https://poncho.io/api/v1/user_sessions')
        .with(
          body: '{"email":"fake@test.com","password":"fake"}',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Faraday v0.15.4'
          }
        )
        .to_return(status: 401, body: '', headers: {})
    end

    subject { described_class.run!(email: 'fake@test.com', password: 'fake') }

    it { is_expected.to be_nil }
  end

  context 'when email and password are wrong' do
    before do
      stub_request(:post, 'https://poncho.io/api/v1/user_sessions')
        .with(
          body: '{"email":"pablo@flimper.com","password":"password"}',
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Faraday v0.15.4'
          }
        )
        .to_return(status: 201, body: '{"jwt_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoiVXNlciIsImVtYWlsIjoicGFibG9AZmxpbXBlci5jb20iLCJhdXRob3JpemF0aW9uX3Rva2VuIjoidGVzdC10b2tlbiIsInBlcm1pc3Npb25zIjpbeyJlbWFpbCI6InBhYmxvQGZsaW1wZXIuY29tIiwicmVzb3VyY2VfY29kZSI6IlRFU1RfQVBJIiwibGV2ZWwiOiJBRE1JTiJ9LHsiZW1haWwiOiJwYWJsb0BmbGltcGVyLmNvbSIsInJlc291cmNlX2NvZGUiOiJURVNUX0FQSV9BRE1JTl9QQU5FTCIsImxldmVsIjoiQURNSU4ifV19.iKuIXdY8awXRgPR40ATFCXUiKPIX5PnXb0OuFsd7XfA"}', headers: {})
    end

    subject { described_class.run!(email: 'pablo@flimper.com', password: 'password') }

    it { is_expected.to_not be_nil }
    it { is_expected.to be_a(FlimperPoncho::Entities::UserSession) }
  end
end
