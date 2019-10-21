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
    it "selects only ten works even when the category contains more than ten" do
      # used Faker because the title must be unique according to Work validations
      15.times do
        Work.create(category: "book", title: Faker::Book.unique.title, creator: "Author")
      end

      top_ten_books = Work.top_ten("book")
      
      expect(top_ten_books.length).must_equal 10
    end
  end
end

