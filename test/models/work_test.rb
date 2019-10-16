require "test_helper"

describe Work do
  describe 'validations' do
    it 'is valid when title and category are present, and release date is an integer' do
      @work = works(:leithauser)
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
end
