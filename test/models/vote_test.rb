require "test_helper"

describe Vote do

  before do 
    @user = User.create(username: "Testguy")
    @work = Work.create(title: "TestTitle", category: "book")
    @vote = Vote.create(user_id: @user.id, work_id: @work.id)
  end 

  #test validations
  #test relationships 
  describe "validations" do 
    it "can be instantiated" do 
      assert(@vote.valid?)
    end 

    it "contains the required fields" do
      [:user_id, :work_id].each do |field|
        expect(@vote).must_respond_to field 
      end 
    end 

    it "must have a work_id" do 
      @vote.work_id = nil
      refute(@vote.valid?)
    end

    it "must have a user_id " do
      @vote.user_id = nil
      refute(@vote.valid?) 
    end 

    it "must have a unique user_id for a single work_id" do 
      #try to create another vote for the same work, and same user id
      expect(Vote.create(user_id:@user_id, work_id: @work_id).valid?).must_equal false
    end 
  end 

  describe "relationships" do 

    it "can have one work" do 
      expect(@vote.work).must_be_instance_of Work 
    end 

    it "belongs to one user" do
      expect(@vote.user).must_be_instance_of User 
    end 


  end 
end

