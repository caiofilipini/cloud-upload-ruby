require File.expand_path("spec/spec_helper")

describe CloudUploadApp do

  it "should be a Rack application" do
    env = {}
    subject.call(env).should == [200, {"Content-Type" => "text/plain"}, ""]
  end

end
