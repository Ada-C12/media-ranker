require "test_helper"

describe HomepagesController do
  it "can get the homepage" do
    work = Work.first
    get root_path
    
    must_respond_with :success
  end
end
