class CloudUploadApp
  def call(env)
    request = Rack::Request.new(env)
    case request.path
    when /\/$/
      FormHandler.new.handle(request)
    else
      NotFoundHandler.new.handle(request)
    end
  end
end
