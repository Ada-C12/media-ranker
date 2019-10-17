require "test_helper"

describe Vote do
  
  before do
    @user = users(:user1)
    @work = works(:kindred)
    
  end
  
  it "can be instantiated" do
    # vote_params = {
    #   vote: {
    #     user_id: user.id, 
    #     work_id: work.id,
    #     date: Date.today
    #   }
    # }
    puts "This is the user id: #{@user.id}"

    vote = Vote.create(user_id: @user.id, work_id: @work.id, date: Date.today)

    expect(vote.valid?).must_equal true
  end
  
end
