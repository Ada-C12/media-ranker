require "test_helper"

describe User do
  let (:new_user) { User.new(name: "Tom") }
  describe 'instantiation' do     
    it 'can be instantiated' do
      # Act-Assert
      expect(new_user.valid?).must_equal true
    end

    it 'will have the required fields' do
      # Arrange
      [:name].each do |field|

      # Assert
      expect(users(:alex)).must_respond_to field
      end
    end
  end
 
  describe "validations" do
    it "must have a name" do
      # Arrange
      users(:dani).name = nil      
      # Act-Assert
      expect(users(:dani).valid?).must_equal false
      expect(users(:dani).errors.messages).must_include :name
      expect(users(:dani).errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  describe 'relations' do
    it 'can set the vote through "vote"' do
      # Arrange
      vote = Vote.new
      
      # Act
      vote.user = users(:dani)
    
       # Assert
      expect(vote.user_id).must_equal users(:dani).id
      # expect(users(:dani).votes).must_equal vote
    end

    # it 'can set the author through "author_id"' do
    #   # Create two models
    #   author = Author.create!(name: "test author")
    #   book = Book.new(title: "test book")

    #   # Make the models relate to one another
    #   book.author_id = author.id

    #   # author should have changed accordingly
    #   expect(book.author).must_equal author
    # end
  end
end
