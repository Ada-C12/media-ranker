require "test_helper"

describe Work do
  describe 'validations' do
    it 'is invalid without a title' do
    end
  end
end


  describe 'relations' do
    it "has an author" do
      book = books(:poodr)
      book.author.must_equal authors(:metz)
    end

    it "can set the author" do
      book = Book.new(title: "test book")
      book.author = authors(:metz)
      book.author_id.must_equal authors(:metz).id
    end
  end
end