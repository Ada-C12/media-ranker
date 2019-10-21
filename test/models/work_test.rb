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

  describe 'relations' do
    it 'can have many votes' do
      assert Work.create.votes
    end
  end

  describe 'methods' do
    before do
      40.times do |n|
        Work.create title: "test work #{ n }", category: Work.categories[n%Work.categories.count] 
      end

      20.times do |n|
        User.create username: "test user #{ n }"
      end

      User.all.each_with_index do |u, i|
        Vote.create(work_id: Work.all[i%12].id, user_id: u.id)
        work = rand(12) until work != i%12
        Vote.create(work_id: work, user_id: u.id)
      end

      User.all.each do |u|
        works_voted = u.votes.map(&:work_id)
        expect(works_voted.count).must_equal works_voted.uniq.count
      end
    end
    
    describe 'spotlight' do
      it 'returns the work with the most votes' do
        uid = User.create(username: "h").id
        Vote.create(work_id: Work.first.id, user_id: uid)

        expect(Work.spotlight.id).must_equal Work.first.id
      end

      it 'chooses alphabetically by title if there is a vote tie' do
        Vote.delete_all
        expect(Work.spotlight.id).must_equal Work.first.id
      end

      it 'returns nil if there are no works' do
        Vote.delete_all
        Work.delete_all
        assert_nil Work.spotlight
      end
    end

    describe 'top ten' do
      it 'for a given category, it returns an array of ten works with the highest vote count, in descending order of votes' do
        Work.categories.each do |cat|
          expect(Work.top_ten cat).must_be_instance_of Array
          expect(Work.top_ten(cat).count).must_equal 10
          assert (Work.top_ten(cat).first.votes.count) > (Work.top_ten(cat).last.votes.count)
          end 
      end
      
      it 'chooses alphabetically by title if there is a vote tie' do
        Vote.delete_all
        
        Work.categories.each do |cat|
          ten = Work.top_ten cat
          assert ten.first.title < ten.last.title
        end
      end

      it 'if there are less than 10 works it returns as many as possible' do
        Vote.delete_all
        Work.categories.each do |cat|
          Work.find_by(category: cat).delete until Work.where(category: cat).count < 10
          expect(Work.top_ten(cat).count).must_equal 9
        end
      end

      it 'returns an empty array if there are no works' do
        Vote.delete_all
        Work.delete_all

        Work.categories.each do |cat|
          assert Work.top_ten(cat).empty?
        end
      end
    end
  end
end
