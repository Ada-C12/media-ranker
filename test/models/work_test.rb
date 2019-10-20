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
    
    it "title must be unique For category" do
      duplicate_title = Work.new(category: "movie", title: "Soup Dumplings", creator: "No one", publication: 1999, description: " ")
      
      expect(duplicate_title.valid?).must_equal false
      expect(duplicate_title.errors.messages).must_include :title
      
    end
    
    it "title can be duplicated in a different category" do
      
      duplicate_title_2 = Work.new(category: "book", title: "Soup Dumplings", creator: "No one", publication: 1999, description: " ")
      
      expect(duplicate_title_2.valid?).must_equal true
      
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
    
    describe 'spotlight' do
      
      it "selects the work with the most votes" do
        
        poodr = works(:poodr)
        bride = works(:bride)
        
        Vote.create(work_id: poodr.id, user_id: 1)
        Vote.create(work_id: poodr.id, user_id: 2)
        Vote.create(work_id: bride.id, user_id: 3)
        
        expect( Work.spotlight[0] ).must_equal poodr
        
      end
      
      it "returns nil if there are no votes" do
        
        Work.destroy_all
        
        assert_nil( Work.spotlight[0] )
        
      end
      
    end
    
    describe 'top_ten' do
      
      it "adds works with one or more votes and works are in the expected order" do
        
        book_1 = Work.create(category: "book", title: "The Plum Cookbook", creator: "Anna Strubinsky", publication: 1994, description: "Plum cookin'.")
        
        book_2 = Work.create(category: "book", title: "Hello Stranger", creator: "Emmylou Harris", publication: 1972, description: " ")
        
        user_1 = User.create(name: "User 1")
        user_2 = User.create(name: "User 2")
        user_3 = User.create(name: "User 3")
        
        Vote.create(work_id: book_1.id, user_id: user_1.id)
        Vote.create(work_id: book_1.id, user_id: user_2.id)
        Vote.create(work_id: book_2.id, user_id: user_3.id)
        
        top_books = Work.top_ten("book")
        
        expect( top_books[0] ).must_equal book_1
        expect( top_books[1] ).must_equal book_2
        
        
      end
      
      it "doesn't add works with zero votes" do
        
        Work.create(category: "album", title: "nobody voted for this album :(", creator: " ", publication: 1987, description: " ")
        Work.top_ten("album")
        expect( Work.top_ten("album").length ).must_equal 0
        
      end
      
      it "returns a maximum of ten works" do
        book_01 = Work.create(category: "book", title: "The Plum Cookbook", creator: "Anna Strubinsky", publication: 1994, description: "Plum cookin'.")
        
        book_02 = Work.create(category: "book", title: "Hello Stranger", creator: "Emmylou Harris", publication: 1972, description: " ")
        
        book_03 = Work.create(category: "book", title: "The Plum Cookbook II", creator: "Anna Strubinsky", publication: 1996, description: "More plum cookin'.")
        
        book_04 = Work.create(category: "book", title: "Hello Danger", creator: "Emmylou Harris", publication: 1974, description: " ")
        
        book_05 = Work.create(category: "book", title: "The Plum Cookbook III", creator: "Anna Strubinsky", publication: 1999, description: "Even more plum cookin'.")
        
        book_06 = Work.create(category: "book", title: "Hello Manger", creator: "Emmylou Harris", publication: 1975, description: " ")
        
        book_07 = Work.create(category: "book", title: "The Plum Cookbook Revisited", creator: "Anna Strubinsky", publication: 2000, description: "Plum cookin' all over again.")
        
        book_08 = Work.create(category: "book", title: "Hello Finger", creator: "Constance Horowitz", publication: 1982, description: " ")
        
        book_09 = Work.create(category: "book", title: "The Plum Stranger", creator: "Anna Strubinsky", publication: 1994, description: "A stranger made of plums.")
        
        book_10 = Work.create(category: "book", title: "Goodbye Stranger", creator: "Emmylou Harris", publication: 2005, description: " ")
        
        book_11 = Work.create(category: "book", title: "The Plum Resource Guide", creator: "Anna Strubinsky", publication: 2006, description: "Plum cookin' repackaged.")
        
        user_1 = User.create(name: "User 1")
        user_2 = User.create(name: "User 2")
        user_3 = User.create(name: "User 3")
        
        Vote.create(work_id: book_01.id, user_id: user_1.id)
        Vote.create(work_id: book_01.id, user_id: user_2.id)
        Vote.create(work_id: book_02.id, user_id: user_3.id)
        Vote.create(work_id: book_03.id, user_id: user_1.id)
        Vote.create(work_id: book_04.id, user_id: user_2.id)
        Vote.create(work_id: book_05.id, user_id: user_3.id)
        Vote.create(work_id: book_06.id, user_id: user_1.id)
        Vote.create(work_id: book_07.id, user_id: user_2.id)
        Vote.create(work_id: book_08.id, user_id: user_3.id)
        Vote.create(work_id: book_09.id, user_id: user_1.id)
        Vote.create(work_id: book_10.id, user_id: user_2.id)
        Vote.create(work_id: book_11.id, user_id: user_3.id)
        
        top_books = Work.top_ten("book")
        
        expect( top_books.length ).must_equal 10
        
      end
      
    end
    
    describe "votes_descending" do 
      
      it "returns all works in a category sorted from most to least votes" do
        
        book_1 = Work.create(category: "book", title: "The Plum Cookbook", creator: "Anna Strubinsky", publication: 1994, description: "Plum cookin'.")
        
        book_2 = Work.create(category: "book", title: "Hello Stranger", creator: "Emmylou Harris", publication: 1972, description: " ")
        
        user_1 = User.create(name: "User 1")
        user_2 = User.create(name: "User 2")
        user_3 = User.create(name: "User 3")
        
        # book_1 gets one vote
        Vote.create(work_id: book_1.id, user_id: user_1.id)
        
        # book_2 gets two votes
        Vote.create(work_id: book_2.id, user_id: user_2.id)
        Vote.create(work_id: book_2.id, user_id: user_3.id)

        books_descending = Work.votes_descending("book")
        
        # book_2 got the most votes so it should show up first
        expect( books_descending[0] ).must_equal book_2
        expect( books_descending[1] ).must_equal book_1
        
      end
      
      it "includes works that have not received any votes" do
       
        unloved_book = Work.create(category: "book", title: "Toenails of the World", creator: " ", publication: 1978, description: " ")

        books_descending = Work.votes_descending("book")
        
        expect( books_descending ).must_include unloved_book

      end
      
    end
    
  end
  
end