require "test_helper"

describe User do
  describe 'validations' do
    it 'is valid with a username' do
      assert User.new(username: "test user").valid?
    end

    it 'is invalid without a username' do
      user = User.new
      refute user.username
      refute user.valid?
    end
  end
end
