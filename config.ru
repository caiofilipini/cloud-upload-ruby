$:.push File.expand_path("../lib", __FILE__)
$:.push File.expand_path(".", __FILE__)

require "rack"
require "cloud_upload"

use Rack::Static,
  :root => "public",
  :urls => ["/js"]

run CloudUploadApp.new

