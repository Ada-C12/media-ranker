require "test_helper"

describe UsersController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe "auth_callback" do
    it "logs in an existing user and redirects to the root route" do
      # Count the users, to make sure we're not (for example) creating
      # a new user every time we get a login request
      start_count = User.count

      # Get a user from the fixtures
      user = users(:grace)

      # Tell OmniAuth to use this user's info when it sees
      # an auth callback from github

      # OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Send a login request for that user
      # Note that we're using the named path for the callback, as defined
      # in the `as:` clause in `config/routes.rb`

      # get auth_callback_path(:github)

      perform_login(user)
      must_redirect_to root_path

      # Since we can read the session, check that the user ID was set as expected
      _(session[:user_id]).must_equal user.id

      # Should *not* have created a new user
      _(User.count).must_equal start_count
    end

    it "creates an account for a new user and redirects to the root route" do
      new_user = users(:grace)
      new_user.uid = 420

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_user))
      expect{ get auth_callback_path(:github) }.must_change "User.count", 1

      must_redirect_to root_path
    end

    it "redirects to the login route if given invalid user data" do
      new_user = User.new(name: "Dani", email: "what@git.com", uid: nil)

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_user))

      expect{ get auth_callback_path(:github) }.wont_change "User.count"

      must_redirect_to root_path
    end
  end
end
