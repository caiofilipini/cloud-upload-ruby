class StatusHandler
  def handle(request)
    uid = request.params["uid"]
    upload_status = CloudUploadApp::IN_PROGRESS[uid]

    return respond_404 unless upload_status

    total = upload_status[:total].to_f
    completed = upload_status[:completed].to_f
    percentage = (completed / total * 100).round

    [200, {"Content-Type" => "application/json"}, StringIO.new("{\"completed\" : \"#{percentage}\"}")]
  end

  private

  def respond_404
    [404, {"Content-Type" => "text/plain"}, StringIO.new("")]
  end
end
