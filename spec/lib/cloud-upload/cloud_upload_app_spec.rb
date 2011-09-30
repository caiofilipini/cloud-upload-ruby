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

    context "/" do
      it "should call FormHandler" do
      end
    end

  end

end
