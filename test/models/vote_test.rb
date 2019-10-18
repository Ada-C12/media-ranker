require "test_helper"

describe Vote do
  describe 'validations' do
    before do
      @vote = Vote.create(work_id: works(:heart).id, user_id: users(:taro).id)
    end
    
    it 'is valid when all valid fields are present' do
      expect(@vote.valid?).must_equal true
    end
    
    it 'is invalid without a user_id' do
      @vote.user = nil
      
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :user
    end
    
    it 'is invalid without a work_id' do
      @vote.work = nil
      
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :work
    end
    
    it 'is invalid if the user has voted on that work before' do
      invalid_vote = Vote.create(work_id: works(:heart).id, user_id: users(:taro).id)
      
      expect(invalid_vote.valid?).must_equal false
    end
    
    it 'is valid if a user votes on a different vote' do
      valid_vote = Vote.create(work_id: works(:blue).id, user_id: users(:taro).id)
      
      expect(valid_vote.valid?).must_equal true
    end
    
    it 'is valid if that user has not voted on that work before' do
      valid_vote = Vote.create(work_id: works(:heart).id, user_id: users(:mario).id)
      
      expect(valid_vote.valid?).must_equal true
    end
  end
  
  describe 'relations' do
    
    it 'can have only one user and one work' do
      vote = Vote.create(work_id: works(:heart).id, user_id: users(:taro).id)
      
      expect(vote.user).must_equal users(:taro)
      expect(vote.work).must_equal works(:heart)
    end
  end
end
