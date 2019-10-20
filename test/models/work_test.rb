require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  describe Work do

    describe "validations" do
      
      it "can be valid" do
        is_valid = works(:valid_work).valid?
        assert( is_valid )
      end
  
      it "is invalid if there is no category" do
        work = works(:invalid_work_without_category)
        is_valid = work.valid?
        refute( is_valid )
      end

      it "is invalid if there is no title" do
        work = works(:invalid_work_without_title)
        is_valid = work.valid?
        refute( is_valid )
      end

      it "is invalid if there is no creator" do
        work = works(:invalid_work_without_creator)
        is_valid = work.valid?
        refute( is_valid )
      end

      it "is invalid if there is no publication_year" do
        work = works(:invalid_work_without_publication_year)
        is_valid = work.valid?
        refute( is_valid )
      end

      it "is invalid if there is no description" do
        work = works(:invalid_work_without_description)
        is_valid = work.valid?
        refute( is_valid )
      end

    end

      describe 'relations' do
        it 'can set the work through "work"' do
          # Create two models
          # work = Work.create!(title: "TestTitle")
          # user = User.new(username: "test user")
    
          # Make the models relate to one another
          user.work = work
    
          # work_id should have changed accordingly
          expect(user.work_id).must_equal work.id
        end
    
        it 'can set the work through "work_id"' do
          # Create two models

          # work = Work.create!(title: "test worl")
          # user = User.new(username: "test user")
    
          # Make the models relate to one another
          user.work_id = work.id
    
          # author should have changed accordingly
          expect(user.work).must_equal work
        end
      end
    
  end
end
