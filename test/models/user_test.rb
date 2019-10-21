require "test_helper"

describe User do
  let (:new_user) {
    users(:new_user)
  }
  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange

    [:username].each do |field|

      # Assert
      expect(new_user).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes" do
      # Arrange
      vote = votes(:new_vote)

      # params = {}
      # params[:user_id] = 1
      # params[:work_id] = 1

      # work = Work.new(title: "MAMOMEMO3", category: "album", publication_year: 2008, creator: "MacMac Do3", description: "A riveting autobiography")
      # vote1 = Vote.create(user_id: params[:user_id], work_id: params[:work_id])
      # vote2 = Vote.create(user_id: params[:user_id], work_id: params[:work_id])

      # new_user = User.first
      # Assert
      expect(new_user.votes.count).must_equal 6
      new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it "must have a username" do
      # Arrange
      new_user.username = nil

      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank", "has already been taken"]
    end
  end
end
