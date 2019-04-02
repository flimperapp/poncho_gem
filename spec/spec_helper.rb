require 'bundler/setup'
require 'flimper_poncho'
require 'byebug'
require 'vcr'
require 'webmock'

ENV['PONCHO_API_URL'] = 'https://poncho.io/api/v1'
ENV['PONCHO_API_SIGNATURE_KEY'] = 'MY-SUPER-SECURE-KEY'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end
