require "test_helper"

describe ApplicationHelper, :helper do

  describe "readable_date" do

    it "gives some string including 'X...ago' when the date is expected" do
      date = Time.now - 3.minutes
      
      result = readable_date(date)

      expect(result).must_include "3 minutes ago"
    end

    it "gives [unknown] when date is nil" do
      
    end

  end

end