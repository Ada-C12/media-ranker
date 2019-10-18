require "test_helper"

describe ApplicationHelper, :helper do
  describe "readable_date" do
    it "produces a tag with the month, day, and year" do
      date = DateTime.current

      result = readable_date(date)
      puts "******* #{result}"

      expect(result).must_be_instance_of String
      expect(result).must_equal date.strftime("%b %d, %Y")
    end

    it "returns [unknown] if the date is nil" do
      date = nil

      result = readable_date(date)

      expect(result).must_equal "[unknown]"
    end
  end
end
