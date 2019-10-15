require "test_helper"

describe Work do
  describe 'validations' do
    before do
      work = { title: 'test title', category: 'album', creator: 'me', published: 2019, description: 'test description' }
      @work = Work.new work
    end

    it 'is valid with all fields' do
      assert @work.valid?
    end

    it 'is invalid without a title' do
      @work.title = nil
      refute @work.valid?
    end

    it 'is valid if title is not unique in a different category' do
      copy_work = Work.new(title: @work.title)
      assert @work.save
      assert copy_work.valid?
    end
    
    it 'is invalid if title is not unique in a different category' do
      copy_work = Work.new(title: @work.title, category: @work.category)
      assert @work.save
      refute copy_work.valid?
    end
  end
end
