require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(category: "album",	title: "Ok", creator:"Georgina",	publication_year:1989, description: "et expedita non aut quo")
    end

    it 'is valid when all fields are present' do
      expect(@work.valid?).must_equal true
    end

    it 'is invalid without a category' do
      @work.category = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
    end
  

    it 'is invalid if the title is not unique' do
      @work.title = works(:hello).title
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without a proper publication year' do
      @work.publication_year = "abc"

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year

      @work.publication_year = nil

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year

      @work.publication_year = 5

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year
    end
  end

  describe 'relationship' do
    it 'can be voted' do
      user = users(:claudia)
      work = works(:hello)
      vote = Vote.create(date: Time.parse("Thu Nov 29 14:33:20 2019"), user_id: user.id, work_id: work.id)
      expect(vote.work.id).must_equal work.id
    end
  end

  describe "albums_work" do
    it "retruns a list of all the works related to the album's category" do
      expect(Work.albums_work.count).must_equal 4
    end
  end

  describe "movies_work" do
    it "retruns a list of all the works related to the movie's category" do
      expect(Work.movies_work.count).must_equal 1
    end
  end

  describe "books_work" do
    it "retruns a list of all the works related to the book's category" do
      expect(Work.books_work.count).must_equal 1
    end
  end


end
