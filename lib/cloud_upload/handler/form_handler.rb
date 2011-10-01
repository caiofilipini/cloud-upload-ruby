class FormHandler
  def handle(request)
    return [405, {}, ""] unless request.get?
    [200, {"Content-Type" => "text/html"}, StringIO.new(form_html)]
  end

  private

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
