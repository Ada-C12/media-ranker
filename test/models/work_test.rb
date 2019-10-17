require "test_helper"

require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "movie", title: "Green Room", creator: "IDK", publication_year: 2016, description: "Scary movie about a punk band that gets trapped by neo-nazis." )
  }

  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|

      # Assert
      assert_respond_to(work, field)
    end
  end

  # describe "relationships" do
  #   it "can have many votes" do
  #     # Arrange
  #     new_work.save
  #     work = Work.first

  #     # Assert
  #     expect(work.votes.count).must_be :>=, 0
  #     work.votes.each do |vote|
  #       expect(vote).must_be_instance_of Vote
  #     end
  #   end
  # end

  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    describe "all_works_categorized" do
      # Your code here
      it "splits the work objects into categories and stores them in a hash" do
        # Arrange
          # make sure there is one work of each category in the test database
        # Act
          # store Work.all_works_categorized into a variable
        # Assert
          # expect the variable:
            # is a hash
            # is of the same length as there are categories
            # has values where the values.category == key
      end
      it "stores the hash value as an empty array if there are no works for the given category/key" do
        # Arrange
          # make sure there are no works in the test database
        # Act
          # store Work.all_works_categorized into a variable
        # Assert
          # expect the variable:
            # is a hash
            # is of the same length as there are categories
            # each value == [] / assert is empty
      end
    end

    describe "top_ten_categorized" do
      it "takes all_works_categorized and filters to only contain the top 10 works, ordered by votes.length descending" do
        # Your code here
        # Arrange
        #   make sure there are 11 works in each category:
        #     1 of them has 2 votes
        #     9 of them has 1 vote
        #     1 of them has 0 votes  <- this one should not exist in the result
        # Act
        #   store Work.top_ten_categorized into a variable
        # Assert
        #   expect the variable:
        #     is a hash
        #     is the same length as there are categories
        #     each value has 10 works
        #     there are no works that have 0 votes
        #     each category's first work has 2 votes
        #     each category's last work has 1 vote
          
      end
      it "filters all_works_categorized and returns all works in a category if there are fewer than 10 works in the category" do
        # Arrange
        #   make sure there are 3 works in each category:
        #     1 of them has 2 votes
        #     1 of them has 1 vote
        #     1 of them has 0 votes
        # Act
        #   store Work.top_ten_categorized into a variable
        # Assert
        #   expect the variable:
        #     is a hash
        #     is the same length as there are categories
        #     each value has <10 works
        #     each category's first work has 2 votes
        #     each category's last work has 0 votes
          
      end
    end

    describe "spotlight" do
      # Your code here
      # Arrange
      # Act
      # Assert
    end
  end
end
