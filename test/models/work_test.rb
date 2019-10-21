require "test_helper"

require "pry"

describe Work do
  describe "instantiation" do
    it "can be instantiated" do
      new_work = Work.new(title: "New book", creator: "Random", category: "book", publication_year: 2000, description: "random description" )

      expect(new_work.valid?).must_equal true
    end
  end

  describe 'validation' do
    before do
      @obama = works(:obama)
    end

    it "is valid when all fields are present" do
      value(@obama).must_be :valid?
    end

    it "is invalid without a title" do
      @obama.title = nil

      expect(@obama.valid?).must_equal false
      expect(@obama.errors.messages).must_include :title
      expect(@obama.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "is invalid without a creator" do
      @obama.creator = nil

      expect(@obama.valid?).must_equal false
      expect(@obama.errors.messages).must_include :creator
      expect(@obama.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it "is invalid without a category" do
      @obama.category = nil

      expect(@obama.valid?).must_equal false
      expect(@obama.errors.messages).must_include :category
      expect(@obama.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "is invalid without a publishing year" do
      @obama.publication_year = nil

      expect(@obama.valid?).must_equal false
      expect(@obama.errors.messages).must_include :publication_year
      expect(@obama.errors.messages[:publication_year]).must_equal ["can't be blank", "is not a number"]
    end

    it "is invalid with a publishing year greater than 1000" do
      @obama.publication_year = 1000

      expect(@obama.valid?).must_equal false
      expect(@obama.errors.messages).must_include :publication_year
      expect(@obama.errors.messages[:publication_year]).must_equal ["must be greater than 1000"]
    end
  end

  describe "relationships" do 
    it "can have many votes" do
      work = works(:obama)
      new_user = User.create(username: "harry potter")
      Vote.create(user_id: new_user.id, work_id: work.id)

      expect(work.votes.count).must_be :>=, 0

      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "custom methods" do
    before do
      3.times do |i|
        three_votes = works(:gay)
        user = User.create(username: i.to_s) 
        Vote.create(user_id: user.id, work_id: three_votes.id)
      end

      2.times do |i|
        two_votes_first = works(:miller)
        user = User.create(username: i.to_s) 
        Vote.create(user_id: user.id, work_id: two_votes_first.id)
      end

      2.times do |i|
        two_votes_second = works(:westover)
        user = User.create(username: i.to_s) 
        Vote.create(user_id: user.id, work_id: two_votes_second.id)
      end
    end

    describe "find_spotlight" do
      it "returns a media with most votes" do
        highest_voted = works(:gay)

        spotlight = Work.find_spotlight

        expect(spotlight).must_equal highest_voted
      end

      it "returns nil if no media" do
        works = Work.all
        works.each do |work|
          work.destroy
        end

        expect(Work.count).must_equal 0
        expect(Work.find_spotlight).must_be_nil
      end
    end

    describe "sort_media" do
      it "returns sorted list of all media" do
        highest_voted = works(:gay)

        sorted_list = Work.sort_media(:book)

        expect(sorted_list[0]).must_equal highest_voted

      end

      it "returns [] when given an invalid category" do
        invalid_sample = Work.sort_media(:songs)

        expect(invalid_sample).must_equal []
      
      end

      it "if two media are tied for votes, media with alphabetically first title appears first on the list" do
        3.times do |i|
          three_votes = works(:obama)
          user = User.create(username: i.to_s) 
          Vote.create(user_id: user.id, work_id: three_votes.id)
        end
        
        alpha_first_title = works(:obama)
        alpha_second_title = works(:gay)

        sorted_list = Work.sort_media(:book)

        expect(sorted_list[0]).must_equal alpha_first_title
        expect(sorted_list[1]).must_equal alpha_second_title
      end
    end

    describe "top_ten" do
      it "returns 10 items of media when given category" do
        top_ten = Work.top_ten(:book)

        expect(top_ten.length).must_equal 10
        top_ten.each do |work|
          expect(work).must_be_kind_of Work
          expect(work.category).must_equal "book"
        end
      end

      it "returns 3 items of media when given category with 3 items" do
        9.times do
          Work.all.first.destroy
        end
        top_ten = Work.top_ten(:book)

        expect(top_ten.length).must_equal 3

        top_ten.each do |work|
          expect(work).must_be_kind_of Work
          expect(work.category).must_equal "book"
        end
      end

      it "returns [] when given an invalid category" do
        invalid_sample = Work.top_ten(:songs)

        expect(invalid_sample).must_equal []
      end
    end
  end
end
