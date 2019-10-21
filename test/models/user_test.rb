require "test_helper"

describe User do
  describe 'validations' do 
    it 'is valid when all fields are present' do
      user = users(:morgan)
      result = user.valid?
      
      expect(result).must_equal true
    end
    
    it 'is invalid without a username' do
      user = users(:morgan)
      user.username = nil
      result = user.valid?
      expect(result).must_equal false
    end
    
    
    it 'is invalid if name is not unique' do
      user = users(:morgan)
      user.username = "elizabeth101"
      result = user.valid?
      expect(result).must_equal false
    end
    
    
    
    describe 'relations' do
      it "can have many votes" do 
        user = users(:elizabeth)
        expect(user.votes.count).must_equal 2
        
      end
    end
    
    
  end
  
end

