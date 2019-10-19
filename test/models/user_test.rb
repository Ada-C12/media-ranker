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
    before do
      @user = User.create username: "test user"
      @work = Work.create title: "test work"
    end
    
    it 'returns true if a user has already voted for a work' do
      Vote.create(user_id: @user.id, work_id: @work.id)
      assert @user.voted? @work
    end
    
    it 'returns false if a user hasnt already voted for a work' do
      refute @user.voted? @work
    end
  end
end
