require "test_helper"

describe User do
  describe 'validations' do
    before do
      @test_user = User.create!(username: "primo")
    end
    
    it 'is valid when a new username is entered' do
      expect(@test_user.valid?).must_equal true
    end
    
    it 'is valid when an existing username is entered' do
      existing_user = users(:hallie)
      expect(existing_user.valid?).must_equal true
    end
    
    it 'is not valid when username is nil' do
      @test_user.username = nil
      expect(@test_user.valid?).must_equal false
      expect(@test_user.errors.messages).must_include :username
    end
  end
  
  describe 'relations' do
    before do
      @test_user = User.create!(username: "primo")
    end
    it 'permits a user to have many votes' do
      user = users(:hallie)
      expect(user.votes.count).must_equal 2
    end
    
    it 'permits a user to have zero votes' do
      expect(@test_user.votes.count).must_equal 0
    end
    
  end
end
