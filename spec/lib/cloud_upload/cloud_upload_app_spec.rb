require File.expand_path("spec/spec_helper")

describe CloudUploadApp do

  context "Rack application" do
    it "should respond to call()" do
      subject.should respond_to :call
    end

    it "should be able to receive environment data as a Hash and return an Array" do
      subject.call(Hash.new).should be_a Array
    end
  end

  context "Route handling" do
    let(:uid) { "4242424242" }

    context "GET /unknown" do
      it "should respond 404" do
        get "/unknown"
        last_response.status.should == 404
      end
    end

    context "GET /" do
      it "should respond ok" do
        get "/"
        last_response.status.should == 200
      end
    end

    context "GET /status" do
      before :each do
        CloudUploadApp::IN_PROGRESS[uid] = {:total => 42, :completed => 42}
      end

      it "should respond ok" do
        get "/status", "uid" => uid
        last_response.status.should == 200
      end
    end

    context "POST /upload" do
      it "should respond ok" do
        post "/upload", "uid" => uid
        last_response.status.should == 200
      end
    end
  end

end
