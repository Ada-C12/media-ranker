require "test_helper"

describe HomepagesController do
  it "Can show homepage" do
    get root_path
    must_respond_with :success
  end
end
