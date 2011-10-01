require File.expand_path('spec/spec_helper')

describe FormHandler do

  subject { FormHandler.new }

  describe "#handle" do
    it "should respond 200 and render the upload form" do
      request = Rack::Request.new("REQUEST_METHOD" => "GET")
      response = subject.handle request
      response[0].should == 200
      response[1]["Content-Type"].should == "text/html"
      response[2].should match /uploadForm/
    end

    it "should respond 405 if method is not GET" do
      request = Rack::Request.new("REQUEST_METHOD" => "POST") 
      response = subject.handle request
      response[0].should == 405
    end
  end
  
end
