require "test_helper"

describe Work do
  let (:album1) { works(:album1) }
  let (:book1) { works(:book1) }
  let (:movie1) { works(:movie1) }
  
  describe "RELATIONS" do
    it "can have many votes" do
      ### NEED Votes Model
    end
    
    it "workObj.votes exists and can return Vote objs" do
      ### NEED Votes Model
    end
  end
  
  describe "VALIDATIONS" do
    it "Can create Work obj with correct attributes" do
      [album1, book1, movie1].each do |piece|
        assert(piece.valid?)
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
        album1
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
    end
    
    it "edge case" do
    end
  end
  
  describe "METHOD: self.all_in()" do
    it "nominal case" do
    end
    
    it "edge case" do
    end
  end
  
  describe "METHOD: self.top_ten_in()" do
    it "nominal case" do
    end
    
    it "edge case" do
    end
  end
end
