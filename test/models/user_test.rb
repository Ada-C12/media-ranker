require "test_helper"

describe User do
  describe 'validations' do
    it 'is valid with a username' do
      assert User.new(username: "test user").valid?
    end

    it 'is invalid without a username' do
      user = User.new
      refute user.username
      refute user.valid?
    end
  end

  describe 'relations' do
    it 'can have many votes' do
      assert User.create.votes
    end
  end

  describe 'voted?' do
    it 'returns true if a user has already voted for a work' do
      
    end
    
    it 'returns false if a user hasnt already voted for a work' do
      
    end
  end
end
