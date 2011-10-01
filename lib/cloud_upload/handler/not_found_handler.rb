class NotFoundHandler
  def handle(request)
    [404, {"Content-Type" => "text/plain"}, StringIO.new("")]
  end
end
