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

    context "GET /unknown" do
      it "should respond 404" do
        get "/unknown"
        last_response.status.should == 404
        last_response.body.should be_empty
      end
    end

    context "GET /" do
      let(:form_handler) { mock('form_handler') }

      before :each do
        FormHandler.stubs(:new).returns(form_handler)
      end

      it "should call FormHandler" do
        form_handler.expects(:handle).returns([200, {}, ""])
        get "/"
      end
    end
  end

end
