require "test_helper"

describe Vote do

  let (:new_vote) { Vote.new(work_id: works(:dahlio).id, user_id: users(:dani).id, date: Time.now) }
  
  describe 'instantiation' do     
    it 'can be instantiated' do
      # Act-Assert
      expect(new_vote.valid?).must_equal true
    end
  end

  describe "validations" do
    it "must have a user_id" do
      # Arrange
      votes(:vote1).user_id = nil      
      # Assert
      expect(votes(:vote1).valid?).must_equal false
      expect(votes(:vote1).errors.messages).must_include :user_id
      expect(votes(:vote1).errors.messages[:user_id]).must_equal ["can't be blank"]
    end

    it "must have a work_id" do
      # Arrange
      votes(:vote1).work_id = nil      
      # Assert
      expect(votes(:vote1).valid?).must_equal false
      expect(votes(:vote1).errors.messages).must_include :work_id
      expect(votes(:vote1).errors.messages[:work_id]).must_equal ["can't be blank"]
    end

    it "must have a date" do
      # Arrange
      votes(:vote1).date = nil      
      # Assert
      expect(votes(:vote1).valid?).must_equal false
      expect(votes(:vote1).errors.messages).must_include :date
      expect(votes(:vote1).errors.messages[:date]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    describe "users" do
      it "belongs to a user" do
        #Arrange
        new_vote.save

        # Act-Assert
        expect(new_vote.user).must_equal users(:dani)
        expect(users(:dani).votes.count).must_equal 1
        expect(users(:dani).votes.first).must_equal new_vote
      end

      it 'can set the user through "user"' do
        # Arrange
        vote_test = Vote.new(work_id: works(:dahlio).id, date: Time.now)
        user_test = users(:alex)
        
        # Act
        vote_test.user = users(:alex)

        # Assert
        expect(vote_test.user_id).must_equal users(:alex).id
      end

      it 'can set the user through "user_id"' do
        vote_test = Vote.new(work_id: works(:dahlio).id, date: Time.now)
        user_test = users(:alex)

        #Arrange-Act
        vote_test.user_id = user_test.id

        # Assert
        expect(vote_test.user).must_equal user_test
      end
    end

    describe "works" do
      it "belongs to a work" do
        #Arrange
        new_vote.save

        # Act-Assert
        expect(new_vote.work).must_equal works(:dahlio)
        expect(works(:dahlio).votes.count).must_equal 1
        expect(works(:dahlio).votes.first).must_equal new_vote
      end

      it 'can set the work through "work"' do
        # Arrange
        vote = Vote.new(user_id: users(:fran).id, date: Time.now)
        work = works(:nemo)
        
        # Act
        vote.work = works(:nemo)

        # Assert
        expect(vote.work_id).must_equal works(:nemo).id
      end

      it 'can set the work through "work_id"' do
        vote = Vote.new(user_id: users(:fran).id, date: Time.now)
        work = works(:nemo)

        #Arrange-Act
        vote.work_id = work.id

        # Assert
        expect(vote.work).must_equal work
      end
    end   
  end
end
