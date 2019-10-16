require "test_helper"
require 'pry'

describe Work do
  let (:new_work) {
    Work.create(category: "book", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc",publication_year: 1993, vote_count: 0)
  }
  let (:new_user) {
    User.create(username: "Emily")
  }

  it "can be instantiated" do
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    new_work.save
    [:category, :title, :creator, :description,:publication_year].each do |field|
      expect(new_work).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes" do
      Vote.create(work_id: new_work.id, user_id: new_user.id)
      Vote.create(work_id: new_work.id, user_id: new_user.id)

      expect(new_work.votes.count).must_equal 2
      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a category" do
      new_work.category = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      new_work.title = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_include "can't be blank"
    end

    it "must have a description" do
      new_work.description = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :description
      expect(new_work.errors.messages[:description]).must_include "can't be blank"
    end  
    
    it "must have a publication_year" do
      new_work.publication_year = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["can't be blank"]
    end 
    
    it "must have a vote_count" do
      new_work.vote_count = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :vote_count
      expect(new_work.errors.messages[:vote_count]).must_include "can't be blank"
    end  

    it "must have unique title by category only" do
      new_work.reload
      new_work2 = Work.create(category: "book", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc",publication_year: 1993, vote_count: 0)
      new_work3 = Work.create(category: "album", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc",publication_year: 1993, vote_count: 0)

      expect(new_work2.valid?).must_equal false
      expect(new_work2.errors.messages).must_include :title
      expect(new_work2.errors.messages[:title]).must_include "has already been taken"
      expect(new_work3.valid?).must_equal true
      expect(new_work3.errors.messages[:title]).wont_include "has already been taken"
    end

    it "title & creator must be between 1 and 150 characters" do
      new_work1 = Work.create(category: "book", title: "", creator: "", description: "Here is a desc",publication_year: 1993, vote_count: 0)
      new_work2 = Work.create(category: "album", title: "I'm a really long title, a title that is so long it is longer than 150 chars. This title is soo soo long and it's probably not really a real work title, someone is just trying to mess with my program.", creator: "I'm a really long creator, a creator that is so long it is longer than 150 chars. This creator is soo soo long and it's probably not really a real work creator, someone is just trying to mess with my program.", description: "Here is a desc",publication_year: 1993, vote_count: 0)

      expect(new_work1.valid?).must_equal false
      expect(new_work1.errors.messages).must_include :title
      expect(new_work1.errors.messages[:title]).must_include "is too short (minimum is 1 character)"
      expect(new_work1.errors.messages).must_include :creator
      expect(new_work1.errors.messages[:creator]).must_include "is too short (minimum is 1 character)"
      
      expect(new_work2.valid?).must_equal false
      expect(new_work2.errors.messages).must_include :title
      expect(new_work2.errors.messages[:title]).must_include "is too long (maximum is 150 characters)"
      expect(new_work2.errors.messages).must_include :creator
      expect(new_work2.errors.messages[:creator]).must_include "is too long (maximum is 150 characters)"
    end
  
    it "description must be between 1 and 350 characters" do
      new_work1 = Work.create(category: "album", title: "Title", creator: "Creator", description: "",publication_year: 1993, vote_count: 0)
      new_work2 = Work.create(category: "album", title: "Title", creator: "Creator", description: "Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.",publication_year: 1993, vote_count: 0)

      expect(new_work1.valid?).must_equal false
      expect(new_work1.errors.messages).must_include :description
      expect(new_work1.errors.messages[:description]).must_include "is too short (minimum is 1 character)"
      
      expect(new_work2.valid?).must_equal false
      expect(new_work2.errors.messages).must_include :description
      expect(new_work2.errors.messages[:description]).must_include "is too long (maximum is 350 characters)"
    end
  
  end

  describe "custom methods" do
    it 'self.categories works correctly' do
    end
    it 'self.all_by_votes works correctly' do
    end
    it 'self.top_by_category works correctly' do
    end
    it 'self.top_work works correctly' do
    end
    it 'upvote_count works correctly' do
    end
    it 'downvote_count works correctly' do
    end
  end
end
