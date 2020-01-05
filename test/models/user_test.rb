require "test_helper"

describe User do
  describe 'validations' do 
    it 'is valid when all fields are present' do
      user = users(:allison)
      result = user.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a name' do
      user = users(:allison)
      user.name = nil
      result = user.valid?
      expect(result).must_equal false
    end

    it 'is invalid if length of name is less than 2' do
      user = users(:allison)
      user.name = "A"
      result = user.valid?
      expect(result).must_equal false
    end

    it 'is valid if length of name is 2' do
      user = users(:allison)
      user.name = "aa"
      result = user.valid?
      expect(result).must_equal true

    end

    it 'is invalid if name is not unique' do
      user = users(:allison)
      user.name = "elizabeth"
      result = user.valid?
      expect(result).must_equal false
    end


  end

  describe 'relations' do
    it "can have many votes" do 
      user = users(:allison)
      expect(user.votes.count).must_equal 2

      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
    
  end

  describe 'custom methods' do

    describe 'order_by_joined' do
      it 'orders the users by joined date' do 
        users = User.order_by_joined

        first = users.first
        last = users.last

        expect(first.joined_date > last.joined_date).must_equal true
      end 
    end  
  end
  
end
