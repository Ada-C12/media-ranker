require "test_helper"

describe Work do
  
  let (:movie) {
    works(:bride)
  }
  
  it "can be instantiated" do
    expect(movie.valid?).must_equal true
  end
  
  it "will have the required field" do
    assert_respond_to(movie[:category], :empty?)
  end
  
  describe "validations" do
    
    it "must have a category" do
      
      no_category = Work.new(category: nil, title: "No category", creator: "No one", publication: 1999, description: " ")
      
      expect(no_category.valid?).must_equal false
      expect(no_category.errors.messages).must_include :category
      
    end

    it "category must be valid" do
      
      invalid_category = Work.new(category: "audiobook", title: "No category", creator: "No one", publication: 1999, description: " ")
            
      expect(invalid_category.valid?).must_equal false
      expect(invalid_category.errors.messages).must_include :category
      
    end
    
    it "must have a title" do
      movie.title = nil
      
      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :title
      expect(movie.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "title must be unique for category" do
      duplicate_title = Work.new(category: "movie", title: "Soup Dumplings", creator: "No one", publication: 1999, description: " ")
            
      expect(duplicate_title.valid?).must_equal false
      expect(duplicate_title
        .errors.messages).must_include :title
      
    end
    
  end
  
  describe 'custom methods' do
    
    describe 'alpha_works' do
      
      it 'correctly alphabetizes works' do
        test_list = Work.alpha_works
        
        expect( test_list[0].title ).must_equal works(:kindred).title
        expect( test_list[-1].title ).must_equal works(:bride).title
        
      end
      
    end

    describe 'top_ten' do
      
      it 'only adds works with at least one vote' do
        # test_list = Work.alpha_works
        
        # expect( test_list[0].title ).must_equal works(:kindred).title
        # expect( test_list[-1].title ).must_equal works(:bride).title
        
      end

      it "works are in the expected order" do

      end

      it "returns the expected number of works" do

      end
      
    end
    
  end
  
end