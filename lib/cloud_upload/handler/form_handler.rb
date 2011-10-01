class FormHandler
  def handle(request)
    return [405, {}, ""] unless request.get?
    [200, {"Content-Type" => "text/html"}, StringIO.new(form_html)]
  end

  private

  def form_html
    File.open("public/form.html", File::RDONLY).read
  end
end
