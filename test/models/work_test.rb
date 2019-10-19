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
    it "must have a unique title within its category" do
      # Arrange
      existing_album_title = works(:album).title
      # Act
      new_album_same_title = Work.create(category: "album", title: existing_album_title, creator: "gamooli", publication_year: 2016, description: "are you trying to add an album with the same title as one we already have?")
      # Assert
      expect(new_album_same_title.valid?).must_equal false
      expect(new_album_same_title.errors.messages).must_include :title
      expect(new_album_same_title.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "allows non-unique titles across categories" do
      # Arrange
      existing_album_title = works(:album).title
      # Act
      new_movie_same_title = Work.create(category: "movie", title: existing_album_title, creator: "IDK", publication_year: 2016, description: "who knows")
      # Assert
      expect(new_movie_same_title.valid?).must_equal true
    end

  end

  # Tests for methods you create should go here
  describe "custom methods" do
    before do
      @categories = ["album", "book", "movie"]
    end
    describe "all_works_categorized" do
      # Your code here
      it "splits the work objects into categories (plural) and stores them in a hash" do
        # Arrange
        # make sure there is one work of each category in the test database
        Work.destroy_all
        @categories.each do |category|
          Work.create(category: category, title: "Any kind of #{category}!", creator: "Who knows", publication_year: 2016, description: "This #{category} is VERY SCAREY" )
        end
        expect(Work.count).must_equal @categories.length
        # Act
        # store Work.all_works_categorized into a variable
        all_works_categorized = Work.all_works_categorized
        # Assert
        # expect the variable:
          # is a hash
        expect(all_works_categorized).must_be_instance_of Hash
          # is of the same length as there are categories
        expect(all_works_categorized.length).must_equal @categories.length
          # has values where the values.category == key
        all_works_categorized.each do |category, works|
          works.each do |work|
            expect(work.category).must_equal category.to_s.singularize
          end
        end
      end

      it "stores the hash value as an empty array if there are no works for the given category/key" do
        # Arrange
        # make sure there are no works in the test database
        Work.destroy_all
        # Act
        # store Work.all_works_categorized into a variable
        all_works_categorized = Work.all_works_categorized
        # Assert
          # expect the variable:
        # is a hash
        expect(all_works_categorized).must_be_instance_of Hash
        # is of the same length as there are categories
        expect(all_works_categorized.length).must_equal @categories.length
        # each value == [] / assert is empty
        all_works_categorized.each do |category, works|
          assert_empty(works)
        end
      end
    end

    describe "top_ten_categorized" do
      it "takes all_works_categorized and filters to only contain the top 10 works, ordered by votes.length descending" do
        # Arrange
        # IS THE FIXTURES
        # Act
        #   store Work.top_ten_categorized into a variable
        top_ten_categorized = Work.top_ten_categorized
        # Assert
        #   expect the variable:
        #     is a hash
        expect(top_ten_categorized).must_be_instance_of Hash
        #     is the same length as there are categories
        expect(top_ten_categorized.length).must_equal @categories.length
        #     each value has 10 works
        top_ten_categorized.each do |category, works|
          expect(works.length).must_equal 10
          category_singular = category.to_s.singularize
          top_category_title = works("top_#{category_singular}".to_sym).title
          expect(works.first.title).must_equal top_category_title
        end
        # first title equals the top title for the category (from the fixture)
      end
      it "filters all_works_categorized and returns all works in a category if there are fewer than 10 works in the category" do
        # Arrange
        #   make sure there are no works in each category
        Work.destroy_all
        # Act
        #   store Work.top_ten_categorized into a variable
        top_ten_categorized = Work.top_ten_categorized
        # Assert
        #   expect the variable:
        #    is a hash
        expect(top_ten_categorized).must_be_instance_of Hash
        #    is the same length as there are categories
        expect(top_ten_categorized.length).must_equal @categories.length
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
