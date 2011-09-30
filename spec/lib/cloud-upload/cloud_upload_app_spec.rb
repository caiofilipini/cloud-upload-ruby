require File.expand_path("spec/spec_helper")

describe CloudUploadApp do
  include Rack::Test::Methods

  def app
    CloudUploadApp.new
  end

  context "Rack application" do
    it "should respond to call()" do
      subject.should respond_to :call
    end

    it "should be able to receive environment data as a Hash and return an Array" do
      subject.call(Hash.new).should be_a Array
    end
  end

  context "Route handling" do

    context "GET /unknown" do
      it "should respond 404" do
        get "/unknown"
        last_response.status.should == 404
        last_response.body.should be_empty
      end
    end

    context "GET /" do
      it "should render upload form" do
        get "/"
        last_response.status.should == 200
        last_response.body.should match /uploadForm/
      end
    end

  end

end
