require "test_helper"

describe UsersController do
  it "must get username:string" do
    get users_username:string_url
    must_respond_with :success
  end

end
