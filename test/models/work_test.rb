require "test_helper"
require "pry"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  let (:new_work) {
    Work.create!(category: "Book", title: "The Fantastic Four", creator: "Wallace Rubenstein", publication_year: "2000", description: "Disgrace")
  }


  # know I have let, but just wanted to see how the fixtures work. This before block is needed for fixtures.
  # before do
  #   @work = works(:exmachina)
  #   @vote = votes(:vote_1)
  #   @user = users(:user_1)
  # end

  describe 'relations' do
    it "can access the votes for each work" do
    
      vote = Vote.create!(work_id: new_work.id, date: Time.now, user_id: @user.id)

      expect(new_work.votes.count).must_equal 1
    end 
  end

  describe "instantiations" do
    it "can be instantiated" do
      expect(@work.valid?).must_equal true
    end 
  end 

  describe "validations" do
    it "must have a category" do
      #Arrange
      new_work.category = nil

      # fixture data does not run validations, so use the let value
      
      #Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      # binding.pry
      expect(new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end 
  

    it "must have a title" do
      #Arrange
      new_work.title = nil

      #Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a unique title" do
      new_work
      new_work2 = Work.new(category: "Book", title: "The Fantastic Four")
      
      expect(new_work2.valid?).must_equal false
    end 
  end 

  describe "find_top_10" do
    it "can find the top 10 of a category" do
      #creeate a test database with 11 instances for each category. 
      # run it through the method and muake sure the length of the returned result
      # is 10

      # edited_works = []
      # edited_works = works.slice(1..-1)

      # edited_works.each_with_index do |work, index|
      #   puts users[index].id
      #   Vote.create!(work_id: work.id, date: Time.now, user_id: users[index].id)
      # end
      
      result = Work.find_top_10("movie")
      expect(result.length).must_equal 10

        i = 0
      
      result.each_with_index do |work, index|
        break if index == 9
        work_votes = work.votes 
        # work_votes2 = result[index + 1].votes
        work_votes2 = result[index + 1]

        expect(work_votes.length).wont_be :<, work_votes2.votes.length
      end 
    end 



    it "returns 1 work if there is only 1 work" do
      result = Work.find_top_10("album")

      expect(result.length).must_equal 1
    end 

    it "returns 0 works if there is no work" do
      result = Work.find_top_10("book")
      expect(result.length).must_equal 0
    end 
  end 

  describe "find_spotlight" do
    
  end

end
