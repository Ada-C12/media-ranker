require "test_helper"

describe Vote do
  describe 'relations' do
    it 'a vote belongs to a work' do
      vote = votes(:hal_movie)
      expect(vote.work_id).must_equal works(:rocky).id
    end
    
    it 'a vote belongs to a user' do
      vote = votes(:hal_movie)
      expect(vote.user_id).must_equal users(:hallie).id
    end
  end
end
