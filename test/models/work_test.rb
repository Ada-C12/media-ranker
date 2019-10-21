require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "book", title: "man of the goods", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg")
  }
  
  describe 'instantiation' do
    it "can be instantiated" do
      # Assert
      expect(new_work.valid?).must_equal true
    end

    it "will have the required fields" do
      # Arrange
      [:category, :title, :creator, :publication_year, :description]
        .each do |field|

        # Assert
        expect(works(:wind)).must_respond_to field
      end
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

  describe "custom methods" do
    describe "spotlight" do
      it "returns the work with more votes" do
        works(:nemo).total_votes = 3
        works(:nemo).save
        expect(Work.spotlight).must_equal works(:nemo)
      end
      
      it "returns the first work when all works have same number of votes" do
        expect(Work.spotlight).must_equal works(:wind)
      end

      it "returns an empty array when there are no works" do
        Work.destroy_all
        expect(Work.spotlight).must_equal []
      end
    end

    describe "top ten" do  
      it "returns an empty array when there are no works" do
        Work.destroy_all
        expect(Work.top_10("book")).must_equal []
        expect(Work.top_10("movie")).must_equal []
        expect(Work.top_10("album")).must_equal []
      end
      
      it "returns the top 10 per category" do
        #Arrange
        works(:wind, :dahlio, :nemo, :beatles, :aerosmith, 
          :nirvana, :others, :lion, :love, :happy).each do |work|
          work.category = "book"
          work.save
        end

        works(:wind, :dahlio, :nemo, :beatles, :aerosmith, 
        :nirvana, :others, :lion, :love, :happy).each do |work|
          work.total_votes = 5
          work.save
        end

        expect(Work.top_10("book").include?(works(:gladiator))).must_equal false
      end

    end
  end
end