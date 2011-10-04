class FormHandler
  FORM_HTML_FILE = "public/form.html"

  def handle(request)
    return [405, {}, ""] unless request.get?
    [200, {"Content-Type" => "text/html"}, StringIO.new(html_with_upload_id)]
  end

  private

  def html_with_upload_id
    read_html_file.gsub(/{{uid}}/, new_upload_id)
  end

  def read_html_file
    File.open(FORM_HTML_FILE, File::RDONLY).read.to_s
  end

  def new_upload_id
    Time.now.to_i.to_s
  end
end
