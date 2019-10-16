require "test_helper"

describe Work do
  let (:new_work) { Work.new(category: "album", title: "Lover", creator: "Taylor Swift", publication_year: 2019, description: "pop") }
  
  describe "initialize" do
    it "can be instantiated" do
      expect(new_work.valid?).must_equal true
    end
    
    it "will have the required fields" do
      work = works(:blue)
      
      [:category, :title, :creator, :publication_year, :description].each do |field|
        expect(work).must_respond_to field
      end
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      work = works(:goodbye)
      
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      
      expect(work.votes.count).must_equal 2
    end
  end
  
  describe "validations" do
    it "must have a category that is album, book, or movie" do
      new_work.category = "cat"
      new_work.save
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["is not included in the list"]
    end
    
    it "must have a title" do
      new_work.title = nil
      new_work.save
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "must have a unique title for that category" do
      duplicate_work = Work.create(category: "book", title: "Hello Town")
      
      expect(duplicate_work.valid?).must_equal false
      expect(duplicate_work.errors.messages).must_include :title
      expect(duplicate_work.errors.messages[:title]).must_equal ["has already been taken"]
    end
    
    it "can have the same title as a work from another category" do
      same_title_work = Work.create(category: "movie", title: "Hello Town")
      
      expect(same_title_work.valid?).must_equal true
    end  
  end
  
  
  #   def self.top_ten(category)
  #     top_ten = Work.where(category: category).sample(10)
  #     return top_ten
  #   end
  
  #   def self.spotlight
  #     spotlight = Work.all.sample(1)
  #     return spotlight[0]
  #   end
  
  
  
  
  
  describe "custom methods" do
    it "can return top ten items from a category" do
      top_albums = Work.top_ten("album")
      
      top_albums.each do |album|
        expect(album).must_be_instance_of Work
      end
      
      expect(top_albums).must_be_instance_of Array
      expect(top_albums.length).must_equal 10
    end
    
    it "can return the top work for the spotlight" do
      spotlight = Work.spotlight
      
      expect(spotlight).must_be_instance_of Work
    end
  end
end
