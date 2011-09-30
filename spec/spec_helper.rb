require "rspec"
require "rack/test"

# requires all files under lib/ directory
Dir[File.dirname(__FILE__) + "/../lib/**/*.rb"].each do |file|
  require file
end

