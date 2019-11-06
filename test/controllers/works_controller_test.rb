require "test_helper"

describe WorksController do
  describe "index action" do

    it "gives back a successful response" do
      get works_path
      must_respond_with :success
    end

    it "gives back a 404 if there are no works available" do
      get works_path
    end

  end

  describe 'show action' do

    it 'responds with a success when id given exists' do
      valid_work = Work.first
      
      get work_path(valid_work.id)

      must_respond_with :success

    end

    it 'responds with a not_found when id given does not exist' do
      get work_path("500")

      must_respond_with :not_found
    end

  end

  describe 'create action' do

    it 'creates a new work successfully with valid data, and redirects the user to the book page' do
      work_hash = {
        work: {
        title: "hdfhd",
        category: "movie",
        description: 'jgdkfjgk',
        publication_date: 1990
        }
      }
   
      expect {
        post works_path, params: work_hash
      }.must_differ 'Work.count', 1

      must_redirect_to root_path
    end

  end

  describe 'update action' do
    before do
      @new_work = Work.create(title: "new work")
    end

    it "updates an existing work successfully and redirects to home" do
      existing_work = Work.first
      updated_work_form_data = {
        work: {
        title: "tom",
        category: "movie",
        description: 'jgdkfjgk',
        publication_date: 1990
        }
      }
      # Act
      expect {
        patch work_path(existing_work.id), params: updated_work_form_data
      }.wont_change 'Work.count'

      # Assert
      expect( Work.find_by(id: existing_work.id).title ).must_equal "iiu"

    end

  end

end

