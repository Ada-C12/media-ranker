require "test_helper"

describe Work do
  describe "validations" do
    let (:new_work) {
      Work.new(
        category: "book", 
        title: "Harry Potter", 
        creator: "JK Rowling", 
        publication_year: 1990,
        description: "great book"
      )
    }
    
    it "can instantiate a valid Work" do
      expect(new_work.save).must_equal true
    end
    
    it "can instantiate a Work with nil for all fields except category and title" do
      new_work.creator = nil
      new_work.publication_year = nil
      new_work.description = nil
      
      expect(new_work.save).must_equal true
    end
    
    it "will have the required fields" do
      new_work.save
      work = Work.last
      
      [:category, :title, :creator, :publication_year, :description].each do |field|
        expect(work).must_respond_to field
      end
    end
    
    it "cannot create a Work without a title" do
      new_work.title = nil
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "cannot create a Work with a non-numerical publication year" do
      new_work.publication_year = "carrot"
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["is not a number"]
    end
    
    it "cannot create a Work with a alpha-numerical publication year" do
      new_work.publication_year = "123abc"
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["is not a number"]
    end
    
    it "cannot create a Work outside the categories of book, movie, or album" do
      new_work.category = "bacon"
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["bacon is not a valid category"]
      
      new_work.category = 123
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["123 is not a valid category"]
    end
    
    it "cannot create a Work with a case-insensitive category" do
      new_work.category = "Album"
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["Album is not a valid category"]
    end
    
    it "cannot create a Work with nil category" do
      new_work.category = nil
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal [" is not a valid category"]
    end
  end
  
  describe "custom methods" do
    describe "self.spotlight" do
      it "returns nil when no works available in database" do
        Work.all.each do |work|
          work.destroy
        end
        
        expect(Work.count).must_equal 0
        
        expect(Work.spotlight).must_be_nil
      end
      
      it "returns a spotlight with the highest number of votes" do
        expect(Work.spotlight.title).must_equal "Titanic"
      end
      
      it "returns one spotlight when there is a tie for max votes" do
        user = users(:henry)
        work = works(:lotr)
        
        Vote.new(user_id: user.id, work_id: work.id)
        
        expect(Work.spotlight.title).must_equal "Titanic"
        expect(Work.spotlight).must_be_instance_of Work
      end
    end
    
    describe "self.list_all_in_category" do
      it "returns all works in the same category" do
        album_count = Work.where(category: "album").count
        book_count = Work.where(category: "book").count
        movie_count = Work.where(category: "movie").count
        
        expect(Work.list_all_in_category("album").count).must_equal album_count
        expect(Work.list_all_in_category("book").count).must_equal book_count
        expect(Work.list_all_in_category("movie").count).must_equal movie_count
      end
      
      it "returns empty array when no works available in database" do
        Work.all.each do |work|
          work.destroy
        end
        
        expect(Work.count).must_equal 0
        
        expect(Work.list_all_in_category("album")).must_equal []
      end
      
      it "returns works in descending order of vote count" do
        expect(Work.list_all_in_category("movie").first.title).must_equal "Titanic"
      end
    end
    
    describe "self.get_top_ten" do
      it "returns empty array when no works available in the category" do
        Work.all.each do |work|
          work.destroy
        end
        
        expect(Work.count).must_equal 0
        
        expect(Work.get_top_ten("album")).must_equal []
        expect(Work.get_top_ten("book")).must_equal []
        expect(Work.get_top_ten("movie")).must_equal []
      end
      
      it "returns all entry when a category contains less than 10 entries" do
        album_count = Work.where(category: "album").count
        expect(album_count).must_equal 3
        
        expect(Work.get_top_ten("album").count).must_equal 3
      end
      
      it "returns all 10 entries when a category contains 10 entries" do
        movie_count = Work.where(category: "movie").count
        expect(movie_count).must_equal 10
        
        expect(Work.get_top_ten("movie").count).must_equal 10
      end
      
      it "only returns 10 entries when a category contains more than 10 entries" do
        book_count = Work.where(category: "book").count
        expect(book_count).must_equal 12
        
        expect(Work.get_top_ten("book").count).must_equal 10
      end
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
    end
  end
end
