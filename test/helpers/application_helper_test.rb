require "test_helper"

describe ApplicationHelper, :helper do
  describe 'readable_date' do
    it "returns a string with the current month abbreviated" do
      date = Date.strptime("10-08-2019", '%m-%d-%Y')
      
      output = format_date(date)

      expect(output).must_include "Oct"
    end

    it "returns [unknown] when date is nil" do
      date = nil

      output = format_date(date)

      expect(output).must_equal "[unknown]"
    end

  end
end
