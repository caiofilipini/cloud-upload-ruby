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
      let(:not_found_handler) { mock('not_found_handler') }

      before :each do
        NotFoundHandler.stubs(:new).returns(not_found_handler)
      end

      it "should call NotFoundHandler" do
        not_found_handler.expects(:handle).returns([404, {}, ""])
        get "/unknown"
        last_response.status.should == 404
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
        last_response.status.should == 200
      end
    end
  end

end
