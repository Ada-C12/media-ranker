require "test_helper"

describe User do
  let(:valid_user) {
    User.create(username: "Some Valid Name")
  }
  describe "validations" do
    it "can be valid" do
      is_valid = valid_user.valid?

      assert( is_valid )
    end

    it "is invalid if there is no username" do
      invalid_user_without_title = User.create(username: "")

      is_valid = invalid_user_without_title.valid?

      refute( is_valid )
    end
  end

  describe "relationships" do
    it "can vote once for a work" do
      valid_vote.save
      first_trip = Trip.first

      expect(first_trip.driver).must_be_instance_of Driver
      expect(first_trip.passenger).must_be_instance_of Passenger
    end
  end
end
