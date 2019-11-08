require "test_helper"

describe HomepagesController do
  describe "index" do
    it "responds with success when there are many works saved" do
      get root_path

      must_respond_with :success
    end
  end
end
