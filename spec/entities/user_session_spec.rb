RSpec.describe FlimperPoncho::Entities::UserSession do
  subject do
    described_class.new(jwt: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoiVXNlciIsImVtYWlsIjoicGFibG9AZmxpbXBlci5jb20iLCJhdXRob3JpemF0aW9uX3Rva2VuIjoidGVzdC10b2tlbiIsInBlcm1pc3Npb25zIjpbeyJlbWFpbCI6InBhYmxvQGZsaW1wZXIuY29tIiwicmVzb3VyY2VfY29kZSI6IlRFU1RfQVBJIiwibGV2ZWwiOiJBRE1JTiJ9LHsiZW1haWwiOiJwYWJsb0BmbGltcGVyLmNvbSIsInJlc291cmNlX2NvZGUiOiJURVNUX0FQSV9BRE1JTl9QQU5FTCIsImxldmVsIjoiQURNSU4ifV19.iKuIXdY8awXRgPR40ATFCXUiKPIX5PnXb0OuFsd7XfA')
  end

  it 'is expected to return the right authorization_token' do
    expect(subject.authorization_token).to eq('test-token')
  end

  it 'is expected to return the right email' do
    expect(subject.email).to eq('pablo@flimper.com')
  end

  it 'is expected to return the right permissions' do
    expect(subject.permissions.class).to eq Array
    expect(subject.permissions)
      .to include(email: 'pablo@flimper.com', resource_code: 'TEST_API', level: 'ADMIN')
  end
end
