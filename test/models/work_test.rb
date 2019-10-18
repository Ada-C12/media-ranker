require "test_helper"

describe Work do
  describe "validations" do
    it "can be valid" do
      is_valid = works(:valid_work).valid?
      assert(is_valid)
    end

    it "is invalid if there is no title" do
      work = works(:invalid_work_without_title)
      is_valid = work.valid?
      refute(is_valid)
    end

    it "is invalid if there is no category" do
      work = works(:invalid_work_without_category)
      is_valid = work.valid?
      refute(is_valid)
    end
  end

  describe "relationships" do
    it 'can set the votes through "vote"' do
      vote = votes(:test_vote)
      user = users(:valid_user)
      work = Work.new(title: "test work", category: "book")

      work.votes = [vote]

      expect(work.votes.first.id).must_equal vote.id
      expect(work.votes.first.user_id).must_equal user.id
    end
  end

  describe "category list" do
    it "returns an array of work instances and the array is sorted by votes'count of the work" do
      work1 = works(:list_work_1)
      work1_vote_count = work1.votes.length

      work2 = works(:list_work_2)
      work2_vote_count = work2.votes.length

      work3 = works(:list_work_3)
      work3_vote_count = work3.votes.length

      list = Work.category_list("ruby")

      correct_order_list = [work1, work2, work3].sort_by { |work| -work.votes.length }
      expect(list).must_be_instance_of Array
      list.each_with_index do |work, index|
        expect(work).must_be_instance_of Work
        expect(work).must_equal correct_order_list[index]
      end
    end

    it "returns an empty array if no work is found in a category" do
      empty_list = Work.category_list("music")
      expect(empty_list).must_equal []
    end
  end

  describe "spotlight" do
    let(:work1) {
      Work.create(title: "POODR1", category: "book")
    }

    let(:work2) {
      Work.create(title: "POODR2", category: "book")
    }

    let(:work3) {
      Work.create(title: "POODR3", category: "book")
    }

    let(:work4) {
      Work.create(title: "POODR4", category: "book")
    }

    let(:vote1) {
      Vote.create(work: work2, user: user1)
    }

    let(:vote2) {
      Vote.create(work: work2, user: user2)
    }

    let(:vote3) {
      Vote.create(work: work3, user: user1)
    }

    let(:user1) {
      User.create(username: "user1")
    }

    let(:user2) {
      User.create(username: "user2")
    }

    it "returns a work with the most votes" do
      Work.destroy_all
      User.destroy_all
      work1.save
      work2.save
      work3.save
      work4.save
      user1.save
      user2.save
      vote1.save
      vote2.save
      vote3.save

      works = Work.all
      work_max_vote = works.first
      max_vote = works.first.votes.length

      works.each do |work|
        vote_length = work.votes.length
        if vote_length > max_vote
          work_max_vote = work
          max_vote = vote_length
        end
      end

      expect(Work.spotlight).must_be_instance_of Work
      expect(Work.spotlight).must_equal work_max_vote
    end

    it "returns the first work if more than one works having the same amount of votes" do
      Work.destroy_all
      User.destroy_all

      work4.save
      work1.save

      expect(Work.spotlight).must_be_instance_of Work
      expect(Work.spotlight).must_equal work4
    end
  end
end
