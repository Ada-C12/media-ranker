require "test_helper"

describe Work do
  
  describe "validations" do

    it "van be valid" do
      is_valid = works(:work1).valid?
      assert( is_valid )
    end

    it "is invalid if there is no title" do 
      work = works(:)

  



end
