require "test_helper"

describe Work do
  let (:valid_work) {
    works(:valid_work)
  }
  it "can be instantiated" do
    expect(valid_work.valid?).must_equal true
  end

  it "will have the required fields" do
    expect(valid_work.category).wont_be_nil
    expect(valid_work.title).wont_be_nil
    expect(valid_work.creator).wont_be_nil
    expect(valid_work.publication_year).wont_be_nil
    expect(valid_work.description).wont_be_nil

    [:category, :title, :creator, :publication_year, :description].each do |attribute|
      expect(valid_work).must_respond_to attribute
    end
  end

  describe "relationships" do
    it "can have many votes" do
      vote = votes(:valid_vote)

      expect(valid_work.votes.count).must_be :>=, 0
      valid_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a category" do
      invalid_work_category = works(:invalid_work_category)

      expect(invalid_work_category.valid?).must_equal false
      expect(invalid_work_category.errors.messages).must_include :category
      expect(invalid_work_category.errors.messages[:category]).must_equal ["can't be blank"]
    end
    
    it "must have a title" do
      invalid_work_title = works(:invalid_work_title)

      expect(invalid_work_title.valid?).must_equal false
      expect(invalid_work_title.errors.messages).must_include :title
      expect(invalid_work_title.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  describe "custom methods" do
    describe "most_votes" do
      before do
        @work2 = works(:work2)
        @work3 = works(:work3)
        @user2 = users(:user2)
      end
      it "returns accurate work with most votes" do
        expect(valid_work.votes.count).must_equal 1
        expect(@work2.votes.count).must_equal 1
        expect(@work3.votes.count).must_equal 2

        expect(Work.most_votes).must_equal @work3
      end

      it "returns in alphabetical order if tied" do
        vote = Vote.create(user: @user2, work: @work2)

        expect(@work2.votes.count).must_equal 2
        expect(@work3.votes.count).must_equal 2

        expect(Work.most_votes).must_equal @work2
      end
    end

    describe "top_ten_movies" do
      it "sorts in reverse alphabetical order if tied" do
        
      end
    end

    describe "top_ten_books" do

    end

    describe "top_ten_albums" do

    end
  end
end
