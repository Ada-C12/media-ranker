require "test_helper"

describe Work do
  
  let (:yml) { let_yml_superhash }
  
  describe "RELATIONS" do
    
    let(:movie1) { yml[:movie1] }
    
    it "can have many votes" do
      assert(movie1.votes.count == 4)
      movie1.votes.each do |vote|
        assert(vote.class == Vote)
        assert(vote.work_id == movie1.id)
      end
    end
    
    it "can add votes" do
      new_vote = Vote.create(work: movie1, user_id: yml[:user6].id)
      assert(movie1.votes.count == 5)
    end
    
    it "work_obj.votes exists and can return Vote objs" do
      movie1.votes.each do |vote|
        assert(vote.class == Vote)
        assert(vote.work.title == movie1.title)
      end 
    end
    
    it "if work_obj gets deleted, its dependent votes are too" do
      assert(movie1.votes.count == 4)
      
      movie1.destroy 
      refute(Work.find_by(title: "joker"))
      
      assert(movie1.votes.count == 0)
      # what happens to the votes themselves? We're testing that in vote_test.rb
    end
    
  end
  
  describe "VALIDATIONS" do
    it "Can create Work obj with correct attributes" do
      categories = %w[movie album book]
      titles = %w[aaa bbb ccc]
      pub_years = [123, 456, 789]
      creators = %w[me you they]
      descriptions = %w[xxx yyy zzz]
      categories.each_with_index do |category, index|
        Work.create!(category: categories[index], 
          title: titles[index], 
          published_year: pub_years[index], 
          creator: creators[index], 
          description: descriptions[index]
        )
        new_work = Work.last
        
        assert(new_work.category == categories[index])
        assert(new_work.title == titles[index])
        assert(new_work.published_year == pub_years[index])
        assert(new_work.votes == [])
        assert(new_work.creator == creators[index])
        assert(new_work.description == descriptions[index])
      end
      
    end
    
    describe "Won't create Work obj, given bogus inputs" do
      it "bogus category" do
        # testing for movie/album/book
        bogus1 = Work.new(category: "garbage", title:"ok", published_year: 1234 )
        refute(bogus1.save)
        expect(bogus1.errors.messages.keys).must_include :category
        expect(bogus1.errors.messages.values).must_include ["Only movie/album/book accepted"]
        
        # testing for presence
        bad_args = ["", nil, "  "]
        bad_args.each do |bad_arg|
          bogus2 = Work.new(category: bad_arg)  
          refute(bogus2.save)
          expect(bogus2.errors.messages.keys).must_include :category
          expect(bogus2.errors.messages.values).must_include ["can't be blank"]
        end
      end
      
      it "bogus title" do
        album1 = yml[:album1]
        bogus3 = Work.new(category:"album", title:album1.title, published_year:album1.published_year)
        refute(bogus3.save)
        expect(bogus3.errors.messages.keys).must_include :title
        expect(bogus3.errors.messages.values).must_include ["has already been taken"]
        
        bad_args = ["", nil, "  "]
        bad_args.each do |bad_arg|
          bogus4 = Work.new(category:"album", title: bad_arg, published_year: 1970)
          refute(bogus4.save)
          expect(bogus4.errors.messages.keys).must_include :title
          expect(bogus4.errors.messages.values).must_include ["can't be blank"]
        end
      end
      
      it "bogus published_year" do
        bad_args = ["", nil, "  "]
        bad_args.each do |bad_arg|
          bogus5 = Work.new(category:"album", title: "ok", published_year: bad_arg)
          refute(bogus5.save)
          expect(bogus5.errors.messages.keys).must_include :published_year
          expect(bogus5.errors.messages.values).must_include ["can't be blank"]
        end
      end
    end
  end
  
  describe "METHOD: spotlight_winner()" do
    it "nominal case" do
      expected_winner = yml[:movie1]
      assert( Work.spotlight_winner == expected_winner)
    end
    
    it "edge case: zero votes for everyone" do
      Vote.destroy_all
      assert(Vote.count == 0)
      result = Work.spotlight_winner
      
      assert(result.id == nil)
      assert(result.title == "N/A")
      assert(result.creator == "NOBODY")
      assert(result.description == "ZERO VOTES for any of the works, that's why you're seeing this super special default message")
    end
  end
  
  describe "METHOD: self.all_in()" do
    it "nominal case: check all correct seeds from db are returned" do
      # checking that Work.all_in(category: "movie") will return relevant objects with matching category
      # ditto with category: "book" or "album"
      
      categories = ["movie", "book", "album"]
      categories.each_with_index do |category, index|
        all_in_category = Work.all_in(category: category)
        if category == "movie"
          assert(all_in_category.count == 11)
        else
          assert(all_in_category.count == 2)
        end
        
        all_in_category.each do |piece|
          assert(piece.category == categories[index])
        end
      end
    end
    
    it "edge case: what if nothing is in database?" do
      Work.destroy_all
      assert(Work.count == 0)
      
      categories = ["movie", "book", "album"]
      categories.each_with_index do |category, index|
        all_in_category = Work.all_in(category: category)
        assert(all_in_category.count == 0)
      end
    end
    
    it "edge case: what if someone requests Work.all_in(category: 'BOGUS')?" do
      bad_args = ["garbage", "MOVIE", "ALBUM", "BOOK", nil, "", "   ", 123]
      bad_args.each do |bad_arg|
        expect { Work.all_in(category: bad_arg) }.must_raise ArgumentError        
      end
    end
  end
  
  describe "METHOD: self.top_ten_in()" do
    it "nominal case: check top 10 seeds in albums are in correct category, and show up in desc order" do
      top10 = Work.top_ten_in(category: "album")
      assert(top10.count == 2)
      assert(desc_order?(top10))
      top10.each do |piece|
        assert(piece.category == "album")
      end
    end
    
    it "nominal case: check top 10 seeds in books are in correct category, and show up in desc order" do
      top10 = Work.top_ten_in(category: "book")
      assert(top10.count == 2)
      assert(desc_order?(top10))
      top10.each do |piece|
        assert(piece.category == "book")
      end
    end
    
    it "nominal case: check top 10 seeds in movies are in correct category, and show up in desc order" do
      top10 = Work.top_ten_in(category: "movie")
      assert(top10.count == 10)
      assert(desc_order?(top10))
      top10.each do |piece|
        assert(piece.category == "movie")
      end
      
      movie11 = yml[:movie11]
      refute(top10.include? movie11)
    end
    
    it "edge case: if no works exist in a category, should return empty array" do
      Work.destroy_all
      assert(Work.count == 0)
      
      %w[movie album book].each do |cat|  
        top10 = Work.top_ten_in(category: cat)
        assert(top10 == [])
      end
    end
    
    it "edge case: if no votes exist in a category, should return array of max 10 in random order" do
      Vote.destroy_all
      assert(Vote.count == 0)
      
      %w[movie album book].each do |cat|  
        top10 = Work.top_ten_in(category: cat)
        assert (top10.length <= 10)
        top10.each do |piece|
          assert(piece.category == cat)
          assert(piece.votes.count == 0)
        end
      end
    end
  end
end
