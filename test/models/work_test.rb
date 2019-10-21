require "test_helper"

describe Work do
  let (:new_user2) {
    User.create(username: "Tacocat")
  }

  it "can be instantiated" do
    assert(works(:new_work).valid?)
  end

  it "will have the required fields" do
    works(:new_work).save
    [:category, :title, :creator, :description,:publication_year, :vote_count].each do |field|
      expect(works(:new_work)).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes" do
      Vote.create(work_id: works(:new_work).id, user_id: users(:new_user).id, vote_type: "upvote")
      Vote.create(work_id: works(:new_work).id, user_id: new_user2.id, vote_type: "upvote")

      expect(works(:new_work).votes.count).must_equal 2
      works(:new_work).votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a category" do
      works(:new_work).category = nil

      refute(works(:new_work).valid?)
      expect(works(:new_work).errors.messages).must_include :category
      expect(works(:new_work).errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      works(:new_work).title = nil

      refute(works(:new_work).valid?)
      expect(works(:new_work).errors.messages).must_include :title
      expect(works(:new_work).errors.messages[:title]).must_include "can't be blank"
    end

    it "must have a description" do
      works(:new_work).description = nil

      refute(works(:new_work).valid?)
      expect(works(:new_work).errors.messages).must_include :description
      expect(works(:new_work).errors.messages[:description]).must_include "can't be blank"
    end  
    
    it "must have a publication_year" do
      works(:new_work).publication_year = nil

      refute(works(:new_work).valid?)
      expect(works(:new_work).errors.messages).must_include :publication_year
      expect(works(:new_work).errors.messages[:publication_year]).must_equal ["can't be blank"]
    end 
    
    it "must have a vote_count" do
      works(:new_work).vote_count = nil

      refute(works(:new_work).valid?)
      expect(works(:new_work).errors.messages).must_include :vote_count
      expect(works(:new_work).errors.messages[:vote_count]).must_include "can't be blank"
    end  

    it "must have unique title by category only" do
      works(:new_work).reload
      invalid_work2 = Work.create(category: "book", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc",publication_year: 1993, vote_count: 0)
      invalid_work3 = Work.create(category: "album", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc",publication_year: 1993, vote_count: 0)

      refute(invalid_work2.valid?)
      expect(invalid_work2.errors.messages).must_include :title
      expect(invalid_work2.errors.messages[:title]).must_include "has already been taken"
      assert(invalid_work3.valid?)
      expect(invalid_work3.errors.messages[:title]).wont_include "has already been taken"
    end

    it "title & creator must be between 1 and 150 characters" do
      invalid_work1 = Work.create(category: "book", title: "", creator: "", description: "Here is a desc",publication_year: 1993, vote_count: 0)
      invalid_work2 = Work.create(category: "album", title: "I'm a really long title, a title that is so long it is longer than 150 chars. This title is soo soo long and it's probably not really a real work title, someone is just trying to mess with my program.", creator: "I'm a really long creator, a creator that is so long it is longer than 150 chars. This creator is soo soo long and it's probably not really a real work creator, someone is just trying to mess with my program.", description: "Here is a desc",publication_year: 1993, vote_count: 0)

      refute(invalid_work1.valid?)
      expect(invalid_work1.errors.messages).must_include :title
      expect(invalid_work1.errors.messages[:title]).must_include "is too short (minimum is 1 character)"
      expect(invalid_work1.errors.messages).must_include :creator
      expect(invalid_work1.errors.messages[:creator]).must_include "is too short (minimum is 1 character)"
      
      refute(invalid_work2.valid?)
      expect(invalid_work2.errors.messages).must_include :title
      expect(invalid_work2.errors.messages[:title]).must_include "is too long (maximum is 150 characters)"
      expect(invalid_work2.errors.messages).must_include :creator
      expect(invalid_work2.errors.messages[:creator]).must_include "is too long (maximum is 150 characters)"
    end
  
    it "description must be between 1 and 350 characters" do
      invalid_work1 = Work.create(category: "album", title: "Title", creator: "Creator", description: "",publication_year: 1993, vote_count: 0)
      invalid_work2 = Work.create(category: "album", title: "Title", creator: "Creator", description: "Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.Here is a description that is too long.",publication_year: 1993, vote_count: 0)

      refute(invalid_work1.valid?)
      expect(invalid_work1.errors.messages).must_include :description
      expect(invalid_work1.errors.messages[:description]).must_include "is too short (minimum is 1 character)"
      
      refute(invalid_work2.valid?)
      expect(invalid_work2.errors.messages).must_include :description
      expect(invalid_work2.errors.messages[:description]).must_include "is too long (maximum is 350 characters)"
    end
  
  end

  describe "custom methods" do
    before do
      @work_1 = works(:new_work)
      @work_2 = Work.create(category: "book", title: "Work 2", creator: "Creator 2", description: "desc", publication_year: 2019, vote_count: 2 )
      @work_3 = Work.create(category: "book", title: "Work 3", creator: "Creator 3", description: "desc", publication_year: 2019, vote_count: 3 )
      @work_4 = Work.create(category: "album", title: "Work 4", creator: "Creator 4", description: "desc", publication_year: 2019, vote_count: 4 )
      @work_5 = Work.create(category: "movie", title: "Work 5", creator: "Creator 5", description: "desc", publication_year: 2019, vote_count: 5 )
    end

    describe 'self.categories' do
      it 'returns unique categories sorted alphabetically' do
        expect(Work.categories).must_equal ["album", "book",  "movie"]
      end

      it 'returns nil if no works' do
        Work.destroy_all
        assert_nil(Work.categories)
      end
    end

    describe 'self.all_by_votes' do
      it 'returns all works sorted by vote_count in descending order' do
        expect(Work.all_by_votes.count).must_equal 5
        expect(Work.all_by_votes.first).must_equal @work_5
        expect(Work.all_by_votes.last).must_equal @work_1
        Work.all_by_votes.each do |work|
          expect(work).must_be_instance_of Work
        end
      end

      it 'returns all works for given category by vote_count in desc order' do
        expect(Work.all_by_votes(category: "book").count).must_equal 3
        expect(Work.all_by_votes(category: "book").first).must_equal @work_3
        expect(Work.all_by_votes(category: "book").last).must_equal @work_1
        
        Work.categories do |category|
          Work.all_by_votes(category: category).each do |work|
            expect(work).must_be_instance_of Work
            expect(work.category).must_equal category
          end
        end
      end
      
      it 'returns nil if no works' do
        Work.destroy_all
        assert_nil(Work.all_by_votes)
      end
    end


    describe 'self.top_by_category' do
      it 'returns given num works by given category ordered by vote count' do
        works = Work.top_by_category(num:2, category:"book")
        expect(works.count).must_equal 2
        expect(works.first).must_equal @work_3
        expect(works.last).must_equal @work_2
      end
      it 'returns nil if no works' do
        Work.destroy_all
        works = Work.top_by_category(num:2, category:"book")
        assert_nil(works)
      end
    end

    describe 'self.top_work' do
      it 'returns top work by vote_count' do
        expect(Work.top_work).must_equal @work_5
      end

      it 'returns nil if no works' do
        Work.destroy_all
        assert_nil(Work.top_work)
      end
    end

    describe 'upvotes/downvotes' do
      before do
        @user = users(:new_user)
        @work1 = works(:new_work)
        @work2 = Work.create(category: "book", title: "book2", creator: "creator", description: "desc", publication_year: 1993, vote_count: 0)
        @work3 = Work.create(category: "book", title: "book3", creator: "creator", description: "desc", publication_year: 1993, vote_count: 0)
        
        @vote1 = Vote.create(user_id: @user.id, work_id: @work1.id, vote_type: "upvote")
        @vote2 = Vote.create(user_id: @user.id, work_id: @work2.id , vote_type: "upvote")
        @vote3 = Vote.create(user_id: @user.id, work_id: @work3.id , vote_type: "downvote")
      end

      describe 'upvotes & upvote_count' do
        it 'returns upvotes (ordered by creation date) for given work' do
          expect(@user.votes.count).must_equal 3
          expect(@user.upvotes.count).must_equal 2

          work_6 = Work.create(category: "book", title: "book6", creator: "creator", description: "desc", publication_year: 1993, vote_count: 0)
          vote4 = Vote.create(user_id: @user.id, work_id: work_6.id, vote_type:"upvote")
          expect(@user.votes.count).must_equal 4
          expect(@user.upvotes.count).must_equal 3
        end
        
        it 'returns nil if no votes' do
          Vote.destroy_all
          assert_nil(@user.upvotes)
        end
        
      end

      describe 'downvotes & downvote_count' do
        it 'returns downvotes (ordered by creation date) for given work' do
          expect(@user.votes.count).must_equal 3
          expect(@user.downvotes.count).must_equal 1
          
          work_6 = Work.create(category: "book", title: "book6", creator: "creator", description: "desc", publication_year: 1993, vote_count: 0)
          vote4 = Vote.create(user_id: @user.id, work_id: work_6.id, vote_type:"downvote")
          expect(@user.votes.count).must_equal 4
          expect(@user.downvotes.count).must_equal 2
        end
        
        it 'returns nil if no works' do
          Vote.destroy_all
          assert_nil(@user.downvotes)
        end
      end
    end

    describe 'rated?' do
    end
  
  end
end
