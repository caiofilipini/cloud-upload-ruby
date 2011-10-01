$:.push File.expand_path("../lib", __FILE__)

require "rspec"
require "rack/test"
require "cloud_upload"

# Rack::Test setup
include Rack::Test::Methods

def app
  CloudUploadApp.new
end

RSpec.configure do |config|
  config.mock_framework = :mocha
end
