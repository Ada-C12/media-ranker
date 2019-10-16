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
      
      movie.category = nil
      
      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :category
      
    end
    
    it "must have a title" do
      movie.title = nil
      
      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :title
      expect(movie.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "title must be unique" do
      movie.title = works(:dumplings).title
      
      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :title
      
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
    
  end
  
end