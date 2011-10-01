class NotFoundHandler
  def handle(request)
    [404, {}, ""]
  end
end
