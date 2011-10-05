require File.expand_path('spec/spec_helper')

describe StatusHandler do

  subject { StatusHandler.new }

  context "when status is not available" do
    it "should respond 404" do
      request = create_request "GET", "/status", "uid=#{Time.now.to_i}"

      response = subject.handle(request)
      response[0].should == 404
    end
  end

  context "when status is available" do
    let(:uid) { Time.now.to_i.to_s }

    it "should respond 200 with status as JSON" do
      CloudUploadApp::IN_PROGRESS[uid] = {:total => 2 ** 20, :completed => (2 ** 20 * 0.25)}
      request = create_request "GET", "/status", "uid=#{uid}"

      response = subject.handle(request)
      response[0].should == 200
      response[1]["Content-Type"].should == "application/json"
      response[2].string.should == "{\"completed\" : \"25\"}"
    end

    it "should round percentage value to an integer" do
      CloudUploadApp::IN_PROGRESS[uid] = {:total => 2048, :completed => 225.28}
      request = create_request "GET", "/status", "uid=#{uid}"

      response = subject.handle(request)
      response[2].string.should == "{\"completed\" : \"11\"}"
    end
  end
end
