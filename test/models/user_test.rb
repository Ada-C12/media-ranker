require "test_helper"

describe User do
  let (:text_user) {
    User.new(name: 'SpongeBob')
  }
  
  describe "initilaiztaion" do
    it "can be instantiated" do
      expect(text_user.valid?).must_equal true
    end
  end 

  describe "validations" do 
    it "must have a name" do
      text_user.name = nil

      expect(text_user.valid?).must_equal false
      expect(text_user.errors.messages).must_include :name
      expect(text_user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      user = User.find_by(name: 'Banana')
      vote_1 = Vote.create(user_id: user.id, work_id: Work.first.id)
      vote_2 = Vote.create(user_id: user.id, work_id: Work.last.id)
      
      expect(user.votes.count).must_be :>, 0
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
