require "test_helper"

describe HomepagesController do
  describe "index" do
    it "should get root path and HomepagesController#Index" do
      get "/"
      get root_path
      must_respond_with :success
    end
  end
end
