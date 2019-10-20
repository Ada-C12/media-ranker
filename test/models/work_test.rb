# test/models/work_test.rb
require "test_helper"

xdescribe Work do
  # describe "validations" do
  #   # Create two models
  #   before do
  #   creator = Creator.create!(name: "test creator") # ! = if fails, throw an ERROR!
  #   book = Book.new(title: "test book", creator: creator, publication_date: 2019)
  #   end
  
  #   it "must be valid" do
  #     # Make the models relate to one another
  #     book.creator = creator
  
  #     # creator_id should have changed accordingly
  #     expect(book.creator_id).must_equal creator.id
  #   end
  
  #   it 'can set the author through "author_id"' do
  #     # Create two models
  #     author = Author.create!(name: "test author")
  #     book = Book.new(title: "test book")
  
  #     # Make the models relate to one another
  #     book.author_id = author.id
  
  #     # author should have changed accordingly
  #     expect(book.author).must_equal author
  #   end
  # end
  
  # describe 'uniqueness' do
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



