require "test_helper"

describe Work do
  let(:valid_work) {
    Work.create(title: "Some Valid Author")
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
  end
end

