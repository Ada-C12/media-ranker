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

    it 'is invalid if the release date is greater than 9999, not a year' do
      @work.release_date = 2042915
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :release_date
    end
  end

  describe 'relations' do
    it 'has votes' do
      work = works(:hello)
      work.votes.length.must_equal 4
    end
  end

  describe 'custom methods' do
    describe 'top_ten' do
      it 'returns ten works' do
        works = Work.all
        expect(Work.top_ten(works).length).must_equal 10
      end
      it 'returns all if there are fewer than 10 available' do
        works = Work.all
        sample_size = works.sample(5)
        expect(Work.top_ten(sample_size).length).must_equal 5
      end
      it 'returns nothing of none  are available' do
        works = []
        expect(Work.top_ten(works).length).must_equal 0
      end
    end

    describe 'sort_works' do
      it 'can sort more than ten things and does not freak out when a work has no votes--nil or 0' do
        works = Work.all
        works = Work.sort_works(works)
        expect(works.length).must_equal 11
        expect(works.first).must_equal works(:hello)
      end
    end
  end
end
