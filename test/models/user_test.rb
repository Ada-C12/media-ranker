require "test_helper"

describe User do
  describe 'validations' do
    before do
      @user = User.create(username: "a user")
    end
    
    it 'is valid when all valid fields are present' do
      expect(@user.valid?).must_equal true
    end
    
    it 'is invalid without a username' do
      @user.username = nil
      
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end
    
    it 'is invalid without a unique username' do
      invalid_user = User.create(username: "a user")
      
      expect(invalid_user.valid?).must_equal false
      expect(invalid_user.errors.messages).must_include :username
    end
  end
  
  describe 'relations' do
    it 'can have multiple votes' do
      user = users(:taro)
      
      expect(user.votes.count).must_equal 2
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
    
    it 'can have no votes' do
      user = users(:no_vote_person)
      
      expect(user.votes.count).must_equal 0
    end
  end
end
