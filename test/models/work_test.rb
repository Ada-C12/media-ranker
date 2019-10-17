require "test_helper"

describe Work do

  describe "validations" do
    it "can be valid" do
      is_valid = works(:valid_work).valid?

      assert(is_valid)
    end

    it "is invalid if there is no title" do
    work = works(:invalid_work)
    is_valid = work.valid?

    refute(is_valid)
    end
  end 

  describe "relationships" do
    it "can have votes" do
    #arrange: there is a valid work, there is a vote

    #act: count the number of votes on that work id?

    #assert: expect count to be accurate
    end
  end
end
