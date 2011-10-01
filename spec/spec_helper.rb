require "rspec"
require "rack/test"

# Rack::Test setup
include Rack::Test::Methods

def app
  CloudUploadApp.new
end

# requires all files under lib/ directory
Dir[File.dirname(__FILE__) + "/../lib/**/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  config.mock_framework = :mocha
end
