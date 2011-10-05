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

def create_request(method, uri, query_string, input_stream = "")
  Rack::Request.new(
    "REQUEST_METHOD" => method,
    "PATH_INFO" => uri,
    "QUERY_STRING" => query_string,
    "rack.input" => StringIO.new(input_stream),
    "CONTENT_LENGTH" => input_stream.size
  )
end
