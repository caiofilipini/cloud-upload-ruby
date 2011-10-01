$:.push File.expand_path("../lib", __FILE__)

require "rack"
require "cloud_upload"

run CloudUploadApp.new

