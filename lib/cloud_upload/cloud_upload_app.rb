require "cloud_upload/handler/form_handler"
require "cloud_upload/handler/not_found_handler"

class CloudUploadApp
  def call(env)
    request = Rack::Request.new(env)

    case request.path
    when /\/$/
      return FormHandler.new.handle(request)
    else
      return NotFoundHandler.new.handle(request)
    end
  end
end
