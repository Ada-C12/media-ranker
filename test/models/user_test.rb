require "test_helper"

describe User do
  describe 'validations' do
    before do
      @user = users(:january)
    end
    it 'is valid when username is present' do
      expect(@user.valid?).must_equal true
    end
    it 'is invalid without a username' do
      @user.username = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end
  end

  describe 'relations' do
  end

  describe 'custom methods' do
  end

end
