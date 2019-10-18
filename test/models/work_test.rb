require "test_helper"

describe Work do
  describe "validations" do
    it "can be valid" do
      is_valid = works(:list_work_1).valid?
      assert(is_valid)
    end

    it "is invalid if there is no title" do
      work = works(:list_work_1)
      work.title = nil
      is_valid = work.valid?
      refute(is_valid)
    end

    it "is invalid if there is no category" do
      work = works(:list_work_1)
      work.category = nil
      is_valid = work.valid?
      refute(is_valid)
    end
  end

  describe "relationships" do
    it 'can set the vote through "votes"' do
      Vote.destroy_all
      vote = Vote.new(user: users(:user1))
      work = works(:list_work_1)
      work.votes = [vote]
      
      expect(work.votes.first).must_equal vote
    end
  end

  describe "category list" do
    it "returns an array of work instances and the array is sorted by votes'count of the work" do
      work1 = works(:list_work_1)
      work2 = works(:list_work_2)
      work3 = works(:list_work_3)
      work4 = works(:list_work_4)

      list = Work.category_list("ruby")

      correct_order_list = [work1, work2, work3, work4].sort_by { |work| -work.votes.length }

      expect(list).must_be_instance_of Array

      list.each_with_index do |work, index|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "ruby"
        expect(work).must_equal correct_order_list[index]
      end
    end

    it "returns an empty array if no work is found in a category" do
      empty_list = Work.category_list("music")
      expect(empty_list).must_equal []
    end

  end

  describe "spotlight" do
    it "returns a work with the most votes" do
      works = Work.all
      list = works.sort_by{|work| work.votes.length}

      expect(Work.spotlight).must_be_instance_of Work
      expect(Work.spotlight).must_equal list.last
    end

    it "returns the first work if more than one works having the same amount of votes" do
      Work.destroy_all

      work1 = Work.create(title: "game1", category: "game")
      work2 = Work.create(title: "game2", category: "game")

      expect(Work.spotlight).must_be_instance_of Work
      expect(Work.spotlight).must_equal work1
    end
  end
end
