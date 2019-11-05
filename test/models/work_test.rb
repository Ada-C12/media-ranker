require "test_helper"
require 'faker'

describe Work do
  let(:valid_work) {
    Work.create(category: "album", title: "Some Valid Title", creator: "Some creator")
  }

  describe "validations" do
    
    it "can be valid" do
      is_valid = valid_work.valid?

      assert( is_valid )
    end

    it "is invalid if there is no title" do
      invalid_work_without_title = Work.create(title: "")

      is_valid = invalid_work_without_title.valid?

      refute( is_valid )
    end

    it "gives an error message if the title given is not unique" do
      invalid_work_with_same_title = Work.create(title: "Some Valid Title")

      is_valid = invalid_work_with_same_title.valid?

      refute( is_valid )

    end
  end
  
  describe "Relations" do
    it "can have a vote" do
      work = works(:cowboy)

      expect(work.votes).must_include votes(:vote1)
    end
  end

  describe "custom methods" do
    describe "top ten method" do
      it "selects only ten works even when the category contains more than ten" do
        # used Faker because the title must be unique according to Work validations
        15.times do
          Work.create(category: "book", title: Faker::Book.unique.title, creator: "Author")
        end

        top_ten_books = Work.top_ten("book")
        
        expect(top_ten_books.length).must_equal 10
      end

      it "selects all works when the category contains fewer than ten works" do
        # used Faker because the title must be unique according to Work validations
        5.times do
          Work.create(category: "book", title: Faker::Book.unique.title, creator: "Author")
        end

        top_books = Work.top_ten("book")
        
        assert( top_books.length < 10 )
      end

      it "returns an empty array when a category contains no works" do
        Work.destroy_all

        top_books = Work.top_ten("book")
        
        expect(top_books.length).must_equal 0
      end
    end

    describe "spotlight method" do
      before do
        Vote.destroy_all
      end
      
      it "displays a random work if no works have votes" do
        work = Work.spotlight

        expect(work).wont_be_nil
      end

      it "displays the work with the most votes" do
        #creates 1 vote for Work.first
        Vote.create(work_id: Work.first.id, user_id: 1)

        #creates 5 votes for Work.last
        5.times do |voter|
          voter = User.create(username: Faker::Name.unique.name)
          Vote.create(work_id: Work.last.id, user_id: voter.id)
        end

        top_work = Work.spotlight

        expect(top_work.title).must_equal Work.last.title
      end

      it "selects the first work if there is a tie" do
        work1 = works(:cowboy)
        work2 = works(:rest)

        Vote.create(work_id: work1.id, user_id: 1)
        Vote.create(work_id: work2.id, user_id: 1)

        top_work = Work.spotlight

        expect(top_work.title).must_equal work1.title
      end
    end
  end
end

