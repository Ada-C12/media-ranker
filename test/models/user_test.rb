require "test_helper"

describe User do
  describe 'validations' do
    it 'can be valid' do
      is_valid = users(:valid_user).valid?
      
      assert(is_valid)
    end
    
    it 'is invalid if the username is blank' do
      user = User.new(username: "")
      is_valid = user.valid?
      refute(is_valid)
    end
  end
  
  describe 'relationships' do
    it 'can have votes' do
      work = works(:valid_work)
      work_2 = works(:valid_work_2)
      user = users(:valid_user)
      
      vote_1 = Vote.create(user: user, work: work)
      vote_2 = Vote.create(user: user, work: work_2)
      
      expect(user.votes.count).must_equal 2
      expect(user.votes.first).must_be_instance_of Vote
    end
  end
end
