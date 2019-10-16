require "test_helper"

describe Vote do
  describe 'relations' do
    it 'has a work' do
      expect(Vote.create).must_respond_to :work
      expect(Vote.create).must_respond_to :work
    end

    it 'has a user' do
      expect(Vote.create).must_respond_to :user_id
      expect(Vote.create).must_respond_to :user
    end
  end
end
