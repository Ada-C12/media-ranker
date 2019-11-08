require "test_helper"

describe User do
  
  let (:new_user) { User.new(name: "Tom") }
  
  describe 'instantiation' do     
    # it 'can be instantiated' do
    #   # Act-Assert
    #   expect(new_user.valid?).must_equal true
    # end

    # it 'will have the required fields' do
    #   # Arrange
    #   [:name].each do |field|

    #   # Assert
    #   expect(users(:alex)).must_respond_to field
    #   end
    # end
  end
 
  describe "validations" do
    # it "must have a name" do
    #   # Arrange
    #   users(:dani).name = nil      
    #   # Act-Assert
    #   expect(users(:dani).valid?).must_equal false
    #   expect(users(:dani).errors.messages).must_include :name
    #   expect(users(:dani).errors.messages[:name]).must_equal ["can't be blank"]
    # end
  end

  # describe "relationships" do
  #   it "can have many votes" do
  #     # Arrange
  #     user = users(:alex)
  #     vote_1 = Vote.create!(work_id: works(:dahlio).id, user_id: user.id, date: Time.now)
  #     vote_2 = Vote.create!(work_id: works(:beatles).id, user_id: user.id, date: Time.now)

  #     # Assert
  #     expect(user.votes.count).must_equal 2
  #   end
  # end

  # describe "custom methods" do
  #   it "sorts the users alphabetically" do
  #     # Arrange
  #     users = users(:dani, :alex, :fran)

  #     # Act-Assert
  #     expect(User.alphabetic.first.name).must_equal "alexander"
  #   end
  # end

  #describe 'guest user ' do
    # it ''
    # end
  #end

  # describe 'authenticated user' do
  #     perform login ...
  # end

  # describe 'wrong user' do
  #     perform login ...
  # end

end
