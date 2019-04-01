require 'bundler/setup'
require 'flimper_poncho'
require 'byebug'
require 'webmock/rspec'

ENV['PONCHO_API_URL'] = 'https://poncho.io/api/v1'
ENV['PONCHO_API_SIGNATURE_KEY'] = 'my-secret-key'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
