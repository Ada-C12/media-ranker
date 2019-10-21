require "test_helper"

describe Work do
  describe "validations" do
    it "can create a new work for valid input" do
      is_valid = works(:album1).valid?
      assert(is_valid)
    end

    it "is invalid if there is no category" do
      work = works(:in_valid_work_without_category)

      is_valid = work.valid?

      refute( is_valid )
    end

    it "is invalid if there is no title" do
      work = works(:in_valid_work_without_title)

      is_valid = work.valid?

      refute( is_valid )
    end

    it "is invalid if there exists another work on DB that has the same name an category" do
      existing_work = works(:album1)
      is_valid = existing_work.valid?
      assert(is_valid)

      new_work = Work.create(title: existing_work.title, category: existing_work.category)
      refute( new_work.valid?)
    end
  end
  
  describe "relationships" do
    it 'can have many votes from different user' do
      valid_user1 = users(:user1)
      valid_user2 = users(:user2)
      valid_work = works(:album1)

      vote1 = Vote.create(user_id: valid_user1.id, work_id: valid_work.id)
      assert(valid_work.votes.include?(vote1))

      vote2 = Vote.create(user_id: valid_user2.id, work_id: valid_work.id)
      assert(valid_work.votes.include?(vote2))
    end


    it "if work is deleted, all votes belong the work should be removed" do
      valid_work = works(:album1)
      
      valid_users = [users(:user1), users(:user2), users(:user3)]
    
      valid_users.each do |user|
        Vote.create(user_id: user.id, work_id: valid_work.id)  
      end

      expect (Vote.count).must_equal valid_users.length

      valid_work.destroy
      expect (Vote.count).must_equal 0
    end
  end

  describe "self.works_sorted_by_category" do
    it "returns list of objects of the same category" do 
      categories = ["book", "movie", "album"]
      categories.each do |category|
        expected_works = Work.where(category: category)
        
        existing_works = Work.works_sorted_by_category(category)
        
        expect(existing_works.length).must_equal expected_works.length
        expect(existing_works.sample.category).must_equal expected_works.sample.category
      end
    end
    
    it "returns empty array if there's no object of provided category found" do
      Work.destroy_all
      expect(Work.count).must_equal 0
      categories = ["book", "movie", "album"]
      categories.each do |category|
        expect(Work.works_sorted_by_category(category)).must_equal []
      end
    end
  end
  
  describe "top_works" do  
    it "returns the list of 10 or less top works sorted by number of votes" do
      categories = ["book", "movie", "album"]
      categories.each do |category|
        top_works = Work.top_works(category)
        assert(top_works.length <= 10)
        
        (top_works.length - 2).times do |index|
          first_work_total_votes = top_works[index].votes.length
          second_work_total_votes = top_works[index + 1].votes.length
          assert(first_work_total_votes >= second_work_total_votes)
        end
      end
    end
    
    it "return empty array if there's no works" do
      Work.destroy_all
      expect (Work.count).must_equal 0
      categories = ["book", "movie", "album"]
      categories.each do |category|
        expect(Work.top_works(category)).must_equal []
      end
    end
  end
  
  describe "highest_rated_work" do  
    it "can return the highest rated work when there're works in DB" do
      users = [users(:user1), users(:user2), users(:user3), users(:user4)]
      spotlight = works(:album1)

      users.each do |user|
        Vote.create(user_id: user.id, work_id: spotlight.id)
      end
      expect (Work.highest_rated_work).must_equal spotlight

      another_work = works(:movie1)
      (users.length - 1).times do |index|
        Vote.create(user_id: users[index].id, work_id: another_work.id)
        expect (Work.highest_rated_work).must_equal spotlight
      end
    end
    
    it "returns nil if there are no works in DB" do
      Work.destroy_all
      spotlight = Work.highest_rated_work()

      assert_nil(spotlight)
    end
  end
end
