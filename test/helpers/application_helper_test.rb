require "test_helper"

describe ApplicationHelper, :helper do
  describe 'readable_date' do
    it "produces a tag with the full timestamp" do
      # Arrange
      date = Date.today - 14

      # Act
      result = readable_date(date)

      # Assert
      expect(result).must_include date.to_s
    end

    it "returns [unknown] if the date is nil" do
      # Arrange
      date = nil
      
      # Act
      result = readable_date(date)

      # Assert
      expect(result).must_equal "[unknown]"
    end
  end
end