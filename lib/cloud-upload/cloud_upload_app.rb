class CloudUploadApp
  def call(env)
    uri = env["PATH_INFO"]
    return respond_200(:body => form_html, :content_type => "text/html") if uri =~ /\/$/
    respond_404
  end

  private

  def respond_200(response)
    respond response.merge(:status => 200)
  end

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

  def form_html
    html = <<-HTML
<html>
  <head>
    <title>Cloud Upload</title>
  </head>
  <body>
    <h1>Upload your music!</h1>
    <div id="main">
      <form id="uploadForm" action="#" method="post" enctype="multipart/form-data">
        <input id="uid" type="hidden" name="userId" value="" />
        <input type="file" name="fileToUpload" id="fileToUpload" />
      </form>
    </div>

    <form id="detailsForm" action="#" method="post">
      <textarea name="details"></textarea>
      <input id="submit" type="submit" value="Save" />
    </form>
  </body>
</html>
    HTML
    html
  end
end
