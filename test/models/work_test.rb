require "test_helper"

describe Work do
  let(:valid_work) {
    Work.create(title: "Some Valid Title")
  }

  describe "validations" do
    
    it "can be valid" do
      is_valid = valid_work.valid?

      assert( is_valid )
    end

    it "is invalid if there is no title" do
      invalid_work_without_title = Work.create(title: "")

      is_valid = invalid_work_without_title.valid?

      refute( is_valid )
    end

    it "gives an error message if the title given is not unique" do
      invalid_work_with_same_title = Work.create(title: "Some Valid Title")

      is_valid = invalid_work_with_same_title.valid?

      refute( is_valid )

    end
  end
  
  describe "Relations" do
    it "can have a vote" do
      work = works(:cowboy)

      expect(work.votes).must_include votes(:vote1)
    end
  end
end

