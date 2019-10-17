require "test_helper"

describe GitController do
  it "must get reset" do
    get git_reset_url
    must_respond_with :success
  end

  it "must get hard" do
    get git_hard_url
    must_respond_with :success
  end

end
