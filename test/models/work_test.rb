require "test_helper"

describe Work do
  let(:valid_work) {
    Work.create(title: "Some Valid Author")
  }
  describe "validations" do
    
    it "can be valid" do
      is_valid = works().valid?

      assert( is_valid )
    end

    it "is invalid if there is no title" do
      book = works(:invalid_book_without_title)

      is_valid = book.valid?

      refute( is_valid )
    end
end

