require "test_helper"
# no validations or methods to test
describe Vote do
  describe 'relations' do
    it 'vote has a user' do
      vote = votes(:vote1)
      vote.user.must_equal users(:january)
    end
    it 'vote has a work' do
      vote = votes(:vote2)
      vote.work.must_equal works(:gentleman)
    end
    it 'can set the user' do
      vote = Vote.new
      vote.user = users(:may)
      vote.user_id.must_equal users(:may).id
    end
    it 'can set the work' do
      vote = Vote.new
      vote.work = works(:abominable)
      vote.work_id.must_equal works(:abominable).id
    end
  end
end
