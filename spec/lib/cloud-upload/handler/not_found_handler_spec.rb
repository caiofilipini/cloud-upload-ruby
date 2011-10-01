require File.expand_path('spec/spec_helper')

describe NotFoundHandler do

  subject { NotFoundHandler.new }

  describe "#handle" do
    it "should respond 404" do
      request = Rack::Request.new({})
      response = subject.handle request
      response[0].should == 404
    end
  end
  
end
