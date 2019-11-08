require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "book", title: "man of the goods", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 0)
  }
  let (:new_work2) {
    Work.new(category: "book", title: "2", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work3) {
    Work.new(category: "book", title: "3", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work4) {
    Work.new(category: "book", title: "4", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work5) {
    Work.new(category: "book", title: "5", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work6) {
    Work.new(category: "book", title: "6", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work7) {
    Work.new(category: "book", title: "7", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work8) {
    Work.new(category: "book", title: "8", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work9) {
    Work.new(category: "book", title: "9", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work10) {
    Work.new(category: "book", title: "20", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
  }
  let (:new_work11) {
    Work.new(category: "book", title: "11", 
      creator: "Josh Howe", publication_year: 2019, description: "gsgdfg", total_votes: 1)
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
      
      it "returns the existing work per category when less than 10" do
        #Arrange
        Work.destroy_all
        
        new_work.save
        
        expect(Work.top_10("book").count).must_equal 1
        expect(Work.top_10("book").first).must_equal new_work
      end


      # it "returns the top 10 per category" do
      #   #Arrange
      #   new_work.save
      #   new_work2.save
      #   new_work3.save
      #   new_work4.save
      #   new_work5.save
      #   new_work6.save
      #   new_work7.save
      #   new_work8.save
      #   new_work9.save
      #   new_work10.save
      #   new_work11.save
        
      #   # expect{(Work.top_10("book")).include?(new_work)}.must_equal false
      #   expect{(Work.top_10("book")).count}.must_equal 10

      # end
    end

    describe "custom methods" do
      it "sorts the works by votes number in descendent order" do
        #Arrange
        works(:wind, :dahlio, :nemo, :beatles, :aerosmith, 
        :nirvana, :others, :lion, :love, :happy, :gladiator).each do |work|
          work.category = "book"
          work.save
        end
        
        #Act
        works(:love).total_votes = 10
        works(:love).save
        works(:gladiator).total_votes = 5
        works(:gladiator).save
        
        #Assert
        expect(Work.sort_desc("book").first).must_equal works(:love)
        expect(Work.sort_desc("book")[1]).must_equal works(:gladiator)
      end
    end
  end
end