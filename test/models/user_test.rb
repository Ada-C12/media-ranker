require "test_helper"

describe User do
  let (:new_user) {
    User.create(username: "testinguser")
  }

  describe "validations" do 
    it "can be instantiated" do 
      expect(new_user.valid?).must_equal true
    end 

    it "will have the required fields" do
      new_user.save
      user = User.first
      expect(user[:username]).must_equal "testinguser"
    end

    it "must have a title" do 
      new_user.save
      new_user.username = nil 
      refute(@new_user)
    end 

    it "wont make another user with that same name" do
      new_user.save
      another_user = User.create(username:"testinguser")

      refute(another_user.valid?)
    end 
  end 

    describe "relationships" do 
      before do 
        new_user.save
        work = Work.create(title:"Toy Story", category:"movie")
        another_work = Work.create(title:"Fantasia", category:"movie")
        vote_1 = Vote.create(work_id:work.id, user_id: new_user.id)
        vote_2 = Vote.create(work_id:another_work.id, user_id: new_user.id)
      end 

      it "can have many votes per user" do 
        expect(new_user.votes[0]).must_be_instance_of Vote
      end 

      it "contains an accurate number of votes per user" do 
        expect(new_user.votes.count).must_equal 2
      end 

    end 
    
end
