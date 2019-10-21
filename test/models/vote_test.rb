require "test_helper"

describe Vote do
  it "can be instantiated" do
    
    vote = votes(:vote1)
    expect(vote.valid?).must_equal true
  end
  
  it 'is invalid if the user_id is repeated' do
    # @book.title = Book.first.title
    vote = votes(:vote5)
    vote.user_id = 76086961
    # book_2 = Book.create( title: @book.title, author: @book.author, publication_date: 2019)
    
    expect(vote.valid?).must_equal false
    expect(vote.errors.messages).must_include :user_id
  end
  
  describe 'relations' do
    describe "relations" do 
      it "belongs to a user" do 
        user = users(:morgan)
        vote = user.votes.first
        expect(vote.valid?).must_equal true
      end
      it "belongs to a work" do 
        work = works(:poodr)
        vote = work.votes.first
        expect(vote.valid?).must_equal true
      end
    end 
  end
  
end



