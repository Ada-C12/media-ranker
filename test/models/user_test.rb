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
    
    # I've not had success with invalidating an empty entry. I added a 'required' 
    # parameter to the login form instead.
  end
  
  describe 'relations' do
    it 'a user can have many votes' do
      user = users(:hallie)
      expect(user.votes.count).must_equal 2
    end
    
  end
end
