require "test_helper"

describe User do
  it "can be instantiated" do
    user = User.create(
      username: "kmosk",
      joined_date: Time.now,
      )
    expect(user.valid?).must_equal true
  end

  it "will have the required fields" do
    user = User.create(
      username: "kmosk",
      joined_date: Time.now,
      )

    user = User.first
    [:username, :joined_date].each do |field|
      expect(user).must_respond_to field
    end
  end

  describe "validations" do
    before do
      @user = User.create(
        username: "kmosk",
        joined_date: Time.now,
        )
    end
    
    it "must have a username" do
      @user.username = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
      expect(@user.errors.messages[:username]).must_equal ["can't be blank"]
    end

    it "must have a joined_date" do
      @user.joined_date = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :joined_date
      expect(@user.errors.messages[:joined_date]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "has many votes" do
      @user = User.create(
        username: "kmosk",
        joined_date: Time.now,
        )
      @user = User.first
      @work = Work.create(
        category: "movie",
        title: "Little Ladies",
        creator: "Benedict Sadat",
        publication_year: 1994,
        description: "Persistent even-keeled toolset",
        )
      @vote = Vote.create(
        date: Time.now,
        user_id: @user.id,
        work_id: @work.id, 
      )

      expect(@user.votes.count).must_be :>, 0
      @user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

  end 

  
end
