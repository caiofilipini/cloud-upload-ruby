class UploadHandler
  CHUNK_SIZE = 512

  def handle(request)
    total_size = request.content_length
    puts "Received #{total_size} bytes."

    uid = request.params["uid"] || ""
    return respond_400 if uid.empty?

    new_file_name = "/tmp/#{uid}"
    completed = 0

    report_progress uid, total_size, completed

    start_time = Time.now

    File.open(new_file_name, "wb") do |new_file|
      until (chunk = request.body.read(CHUNK_SIZE)).nil?
        new_file.write chunk
        completed = completed + chunk.size
        report_progress uid, total_size, completed
      end
    end

    puts "Finished writing #{completed} bytes to #{new_file_name} in #{time_diff(start_time, Time.now)}."

    [200, {"Content-Type" => "text/plain"}, StringIO.new("upload ok")]
  end

  private

  def respond_400
    [400, {"Content-Type" => "text/plain"}, StringIO.new("")] 
  end

  def report_progress(uid, total_size, completed)
    CloudUploadApp::IN_PROGRESS[uid] = {:total => total_size, :completed => completed }
  end

  def time_diff(start_time, end_time)
    diff = end_time - start_time
    "#{diff.round(2)} seconds"
  end
end
