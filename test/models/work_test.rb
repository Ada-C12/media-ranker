require "test_helper"

describe Work do
  let (:valid_work) {
    works(:valid_work)
  }
  it "can be instantiated" do
    expect(valid_work.valid?).must_equal true
  end

  it "will have the required fields" do
    [:category, :title, :creator, :publication_year, :description].each do |attribute|
      expect(valid_work).must_respond_to attribute
    end
  end

  describe "relationships" do
    it "can have many votes" do
      vote = votes(:vote1)

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

    end

    describe "top_ten_movies" do

    end

    describe "top_ten_books" do

    end

    describe "top_ten_albums" do

    end
  end
end
