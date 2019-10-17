require "test_helper"

describe Work do
  it "can be instantiated" do
    expect(works(:new_work).valid?).must_equal true
  end

  it "will have the required fields" do
    works(:new_work).save
    [:category, :title, :creator, :description,:publication_year].each do |field|
      expect(works(:new_work)).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes" do
      Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id)
      Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id)

      expect(works(:new_work).votes.count).must_equal 2
      works(:new_work).votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a category" do
      works(:new_work).category = nil

      expect(works(:new_work).valid?).must_equal false
      expect(works(:new_work).errors.messages).must_include :category
      expect(works(:new_work).errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      works(:new_work).title = nil

      expect(works(:new_work).valid?).must_equal false
      expect(works(:new_work).errors.messages).must_include :title
      expect(works(:new_work).errors.messages[:title]).must_include "can't be blank"
    end

    it "must have a description" do
      works(:new_work).description = nil

      expect(works(:new_work).valid?).must_equal false
      expect(works(:new_work).errors.messages).must_include :description
      expect(works(:new_work).errors.messages[:description]).must_include "can't be blank"
    end  
    
    it "must have a publication_year" do
      works(:new_work).publication_year = nil

      expect(works(:new_work).valid?).must_equal false
      expect(works(:new_work).errors.messages).must_include :publication_year
      expect(works(:new_work).errors.messages[:publication_year]).must_equal ["can't be blank"]
    end 
    
    it "must have a vote_count" do
      works(:new_work).vote_count = nil

      expect(works(:new_work).valid?).must_equal false
      expect(works(:new_work).errors.messages).must_include :vote_count
      expect(works(:new_work).errors.messages[:vote_count]).must_include "can't be blank"
    end  

    it "must have unique title by category only" do
      works(:new_work).reload
      invalid_work2 = Work.create(category: "book", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc",publication_year: 1993, vote_count: 0)
      invalid_work3 = Work.create(category: "album", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc",publication_year: 1993, vote_count: 0)

      expect(invalid_work2.valid?).must_equal false
      expect(invalid_work2.errors.messages).must_include :title
      expect(invalid_work2.errors.messages[:title]).must_include "has already been taken"
      expect(invalid_work3.valid?).must_equal true
      expect(invalid_work3.errors.messages[:title]).wont_include "has already been taken"
    end

    it "title & creator must be between 1 and 150 characters" do
      invalid_work1 = Work.create(category: "book", title: "", creator: "", description: "Here is a desc",publication_year: 1993, vote_count: 0)
      invalid_work2 = Work.create(category: "album", title: "I'm a really long title, a title that is so long it is longer than 150 chars. This title is soo soo long and it's probably not really a real work title, someone is just trying to mess with my program.", creator: "I'm a really long creator, a creator that is so long it is longer than 150 chars. This creator is soo soo long and it's probably not really a real work creator, someone is just trying to mess with my program.", description: "Here is a desc",publication_year: 1993, vote_count: 0)

      expect(invalid_work1.valid?).must_equal false
      expect(invalid_work1.errors.messages).must_include :title
      expect(invalid_work1.errors.messages[:title]).must_include "is too short (minimum is 1 character)"
      expect(invalid_work1.errors.messages).must_include :creator
      expect(invalid_work1.errors.messages[:creator]).must_include "is too short (minimum is 1 character)"
      
      expect(invalid_work2.valid?).must_equal false
      expect(invalid_work2.errors.messages).must_include :title
      expect(invalid_work2.errors.messages[:title]).must_include "is too long (maximum is 150 characters)"
      expect(invalid_work2.errors.messages).must_include :creator
      expect(invalid_work2.errors.messages[:creator]).must_include "is too long (maximum is 150 characters)"
    end
  
    it "description must be between 1 and 350 characters" do
      invalid_work1 = Work.create(category: "album", title: "Title", creator: "Creator", description: "",publication_year: 1993, vote_count: 0)
      invalid_work2 = Work.create(category: "album", title: "Title", creator: "Creator", description: "Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.",publication_year: 1993, vote_count: 0)

      expect(invalid_work1.valid?).must_equal false
      expect(invalid_work1.errors.messages).must_include :description
      expect(invalid_work1.errors.messages[:description]).must_include "is too short (minimum is 1 character)"
      
      expect(invalid_work2.valid?).must_equal false
      expect(invalid_work2.errors.messages).must_include :description
      expect(invalid_work2.errors.messages[:description]).must_include "is too long (maximum is 350 characters)"
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
