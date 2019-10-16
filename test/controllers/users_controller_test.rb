require "test_helper"

describe UsersController do
  it "must get login" do
    get users_login_url
    must_respond_with :success
  end

  it "must get show" do
    get users_show_url
    must_respond_with :success
  end

end
