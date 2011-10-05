require File.expand_path('spec/spec_helper')

describe UploadHandler do

  subject { UploadHandler.new }

  describe "#handle" do
    context "when uid is not provided" do
      it "should respond 400" do
        request = create_request "POST", "/upload", ""

        response = subject.handle(request)
        response[0].should == 400
      end
    end

    context "when uid is provided, but empty" do
      it "should respond 400" do
        request = create_request "POST", "/upload", "uid="

        response = subject.handle(request)
        response[0].should == 400
      end
    end

    context "when uid is valid" do
      let(:uid) do
        Time.now.to_i.to_s
      end

      let(:body_stream) do
        string_with_size(1024)
      end

      let(:request) do
        create_request "POST", "/upload", "uid=#{uid}", body_stream
      end

      it "should respond 200" do
        response = subject.handle(request)
        response[0].should == 200
      end

      it "should write file to the specified directory" do
        response = subject.handle(request)
        File.read("/tmp/#{uid}").should == body_stream
      end

      context "progress reporting" do
        before :each do
          @request = mock("request")
          @request.stubs(:content_length).returns(1024)
          @request.stubs(:params).returns({"uid" => uid})

          body = mock("request body")
          # simulating a partial read to be able to check progress
          body.stubs(:read).returns(string_with_size(340), nil)
          @request.stubs(:body).returns(body)
        end

        it "should be updated as chunks are written to file" do
          response = subject.handle(@request)
          CloudUploadApp::IN_PROGRESS[uid].should == {:total => 1024, :completed => 340}
        end
      end
    end
  end
end

def string_with_size(size)
  string = ""; size.times { string << "*" }
  string
end
