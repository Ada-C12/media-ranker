require "test_helper"

describe Work do
  let (:text_work) {
    Work.new(
      category: "book",
      title: "text book",
      creator: "anonymous",
      publication_year: 2010
    )
  }
  
  describe "initilaiztaion" do
    it "can be instantiated" do
      expect(text_work.valid?).must_equal true
    end
  end 

  describe "validations" do 
    it "must have a category" do
      text_work.category = nil

      expect(text_work.valid?).must_equal false
      expect(text_work.errors.messages).must_include :category
      expect(text_work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      text_work.title = nil

      expect(text_work.valid?).must_equal false
      expect(text_work.errors.messages).must_include :title
      expect(text_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a creator" do
      text_work.creator = nil

      expect(text_work.valid?).must_equal false
      expect(text_work.errors.messages).must_include :creator 
      expect(text_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it "must have a publication year" do
      text_work.publication_year = nil

      expect(text_work.valid?).must_equal false
      expect(text_work.errors.messages).must_include :publication_year 
      expect(text_work.errors.messages[:publication_year]).must_equal ["can't be blank", "is not a number"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      work = Work.find_by(title: 'B')
      vote_1 = Vote.create(user_id: User.first.id, work_id: work.id)
      vote_2 = Vote.create(user_id: User.last.id, work_id: work.id)
      
      expect(work.votes.count).must_be :>, 0
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end