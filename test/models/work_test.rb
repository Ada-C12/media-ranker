# test/models/work_test.rb
require "test_helper"

describe Work do
  let (:book) {works(:kindred)}
  let (:album) {works(:adalovelace)}
  let (:movie) {works(:funnyface)}
  
  describe "validations" do
    
    it "must be valid" do
      expect(book.valid?).must_equal true
    end
    
    it "will not be valid if no title is given" do
      book.title = nil 
      expect(book.save).must_equal false
    end
    
    it "will fail if title is not unique" do
      new_work = Work.new(title: book.title)
      expect(new_work.save).must_equal false
    end
    
    it "will fail if publication date is not an integer" do
      book.publication_date = "eeee"
      expect(book.save).must_equal false
    end
  end
  
  # xdescribe 'uniqueness' do
  #   before do
  #     # Arrange
  #     @author = Author.new(name: 'test author')
  #     @work = Work.create(title: 'test book', author: @author, publication_date: 2019)
  #   end
  
  #   it 'it shouldnt make a book with the same title' do
  #     book1 = Book.create(title: 'test book', author: @author, publication_date: 2019)
  
  #     expect(book1.valid?).must_equal false
  #     expect(book1.errors.messages).must_include :title
  #   end
  
  #   it 'should be valid with a valid title' do
  #     book2 = Book.new(title: 'not a book', author: @author, publication_date: 2019)
  
  #     expect(book2.valid?).must_equal true
  #   end
  # end
end#end of describe



