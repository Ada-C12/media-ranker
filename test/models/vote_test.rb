require "test_helper"

describe Vote do
  it "can be instantiated" do 
    user = User.create(
      username: "kmosk",
      joined_date: Time.now,
    )
    work = Work.create(
      category: "movie",
      title: "Little Ladies",
      creator: "Benedict Sadat",
      publication_year: 1994,
      description: "Persistent even-keeled toolset",
    )
    vote = Vote.create(
      date: Time.now,
      user_id: user.id,
      work_id: work.id, 
    )

    expect(vote.valid?).must_equal true
  end 

  it "will have the required fields" do
    user = User.create(
      username: "kmosk",
      joined_date: Time.now,
    )
    work = Work.create(
      category: "movie",
      title: "Little Ladies",
      creator: "Benedict Sadat",
      publication_year: 1994,
      description: "Persistent even-keeled toolset",
    )
    vote = Vote.create(
      date: Time.now,
      user_id: user.id,
      work_id: work.id, 
    )

    vote = Vote.first
    [:date, :user_id, :work_id].each do |field|
      expect(vote).must_respond_to field
    end
  end 

  describe "validations" do
    before do
      @user = User.create(
        username: "kmosk",
        joined_date: Time.now,
      )
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
    end
    it "must have a date" do
      @vote.date = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :date
      expect(@vote.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it "must have a user" do
      @vote.user_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :user
      expect(@vote.errors.messages[:user]).must_equal ["must exist", "can't be blank"]
    end

    it "must have a work" do
      @vote.work_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :work
      expect(@vote.errors.messages[:work]).must_equal ["must exist", "can't be blank"]
    end
  end

  describe "relationships" do
    before do
      @user = User.create(
        username: "kmosk",
        joined_date: Time.now,
      )
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
    end
    
    it "belongs to a user" do
      assert_not_nil(@vote.user_id)
    end

    it "belongs to a work" do
      assert_not_nil(@vote.work_id)
    end
  end

end
