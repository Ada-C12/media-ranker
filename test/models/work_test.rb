require "test_helper"

describe Work do
  describe "validations" do
    before do
      @work = Work.new(category: "album", title: "Lemonade", creator: "Beyonce", publication_year: 2016, description: "Sixth studio album")
    end
    it "is valid when all fields are present" do
      result = @work.valid?

      expect(result).must_equal true
    end
  end
end
