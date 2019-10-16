require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = works(:leithauser)
    end
    it 'is valid when title and category are present, and release date is an integer' do
      expect(@work.valid?).must_equal true
    end
    it 'is invalid without a title' do
      @work.title = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without a category' do
      @work.category = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it 'is invalid if the release date is not an integer' do
      @work.release_date = 'abc'
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :release_date
    end
  end

  describe 'relations' do
    #TKTKTKTKTKTKTKTKTKTK
  end

  describe 'custom methods' do
    describe 'top_ten' do
      it 'returns ten books' do
        works = Work.all
        expect(works.top_ten.length).must_equal 10
      end
      it 'returns all if there are fewer than 10 available' do
        works = Work.all
        sample_size = works.sample(5)
        expect(sample_size.top_ten.length).must_equal 5
      end
      it 'returns nothing of none  are available' do
        works = []
        expect(works.top_ten.length).must_equal 0
      end
    end
  end
end
