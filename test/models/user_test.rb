require "test_helper"

describe User do
  describe 'validations' do
    it 'is valid when all fields are present' do
      expect(users(:georgina).valid?).must_equal true
    end
  end

  describe 'relationship' do
    it 'can vote' do
      user = users(:claudia)
      work = works(:hello)
      vote = Vote.create(date: Time.parse("Thu Nov 29 14:33:20 2019"), user_id: user.id, work_id: work.id)
      expect(vote.user.id).must_equal user.id
    end
  end

  describe 'spotlight' do
    it 'returns the work with more votes' do
      user1 = users(:georgina)
      work1 = works(:hello)
      vote1 = Vote.create(date: Time.parse("Thu Nov 29 14:33:21 2019"), user_id: user1.id, work_id: work1.id)
      user2 = users(:claudia)
      work2 = works(:hello)
      vote2 = Vote.create(date: Time.parse("Thu Nov 29 14:33:20 2019"), user_id: user2.id, work_id: work2.id)
      user3 = users(:claudia)
      work3 = works(:world)
      vote3 = Vote.create(date: Time.parse("Thu Nov 29 14:33:22 2019"), user_id: user3.id, work_id: work3.id)
      
      expect(Vote.spotlight).must_equal works(:hello)
    end

    it 'returns nil with no votes' do
      user1 = users(:georgina)
      work1 = works(:hello)
      user2 = users(:claudia)
      work2 = works(:hello)
      expect(Vote.spotlight).must_be_nil
    end
  end 
  
  describe 'top_ten' do
    it 'returns the top ten works for each category' do
      user1 = users(:georgina)
      work1_album = works(:hello)
      vote1 = Vote.create(date: Time.parse("Thu Nov 29 14:33:21 2019"), user_id: user1.id, work_id: work1_album.id)
      user3 = users(:claudia)
      work3_album = works(:world)
      vote3 = Vote.create(date: Time.parse("Thu Nov 29 14:33:22 2019"), user_id: user3.id, work_id: work3_album.id)
      work4_movies = works(:movies_work)
      user4 = users(:claudia)
      vote4 = Vote.create(date: Time.parse("Thu Nov 29 14:33:22 2019"), user_id: user4.id, work_id: work4_movies.id)
      user2 = users(:claudia)
      work2_album = works(:hello)
      vote2 = Vote.create(date: Time.parse("Thu Nov 30 14:33:20 2019"), user_id: user2.id, work_id: work2_album.id)
      
      expect(Vote.top_ten("album").count).must_equal 2
    end
  end
end
