class CloudUploadApp
  def call(env)
    request = Rack::Request.new(env)
    case request.path
    when /\/$/
      return FormHandler.new.handle(request)
    else
      respond_404
    end
  end

  private

  def respond_404
    response = {:status => 404}
    respond response
  end

  def respond(response)
    body = response[:body] || ""
    content_type = response[:content_type] || "text/plain"
    [
      response[:status],
      {"Content-Type" => content_type},
      StringIO.new(body)
    ]
  end

end
