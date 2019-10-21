require "test_helper"

describe Work do
  describe 'validations' do
    
    it 'is valid when all fields are present' do
      # Act
      work = works(:poodr)
      result = work.valid?
      
      # Assert
      expect(result).must_equal true
    end
    
    it 'is invalid without a title' do
      work = works(:poodr)
      work.title = nil
      
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
    end
    
    it 'is invalid if the title is not unique' do
      # @book.title = Book.first.title
      work = works(:poodr)
      work.title = "Parable of the Sower"
      # book_2 = Book.create( title: @book.title, author: @book.author, publication_date: 2019)
      
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
    end
  end
  
  describe 'relations' do
    it "has many votes" do
      work = works(:poodr)
      expect(work.votes.count).must_equal 3
    end
    
  end
  
  
end
