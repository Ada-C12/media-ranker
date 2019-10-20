require "test_helper"

describe Vote do
  describe 'relations' do
    it 'a vote belongs to a work' do
      vote = votes(:hal_book)
      expect(vote.work_id).must_equal works(:green).id
    end
    
    it 'a vote belongs to a user' do
      vote = votes(:hal_book)
      expect(vote.user_id).must_equal users(:hallie).id
    end
  end
end
