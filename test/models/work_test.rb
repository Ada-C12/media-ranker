require "test_helper"

  describe Work do
    let (:new_work) {
      Work.new(category: "book", title: "man of the goods", creator: "Josh Howe", publication_year: 2019, description: "gsgdfg")
    }
    it "can be instantiated" do
      # Assert
      expect(new_work.valid?).must_equal true
    end

    it "will have the required fields" do
      # Arrange
      [:category, :title, :creator, :publication_year, :description].each do |field|

      # Assert
      expect(works(:wind)).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      works(:wind).title = nil      
      # Assert
      expect(works(:wind).valid?).must_equal false
      expect(works(:wind).errors.messages).must_include :title
      expect(works(:wind).errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'is invalid if the title is not unique' do
      @work = Work.new(category: 'book', title: 'a', creator: 'hgkjhj', publication_year: 2019, description: 'jkjl')
      @work.title = works(:dahlio).title

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it "must have a category" do
      # Arrange
      works(:wind).category = nil      
      # Assert
      expect(works(:wind).valid?).must_equal false
      expect(works(:wind).errors.messages).must_include :category
      expect(works(:wind).errors.messages[:category]).must_equal ["can't be blank"]
    end
  end
end
