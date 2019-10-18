require "test_helper"

describe WorksController do

  describe "index" do
    it "responds with success when there are many works saved" do
      new_work = works(:miller)

      get works_path

      must_respond_with :success
    end

    it "responds with success when there are no works saved" do
      works.each do |work|
        work.destroy
      end

      expect(Work.count).must_equal 0

      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid work" do
      get work_path(works(:adichie).id)

      must_respond_with :success
    end

    it "responds with redirect with an invalid work id" do
      invalid_id = -1

      get work_path(invalid_id)

      must_respond_with :redirect
      must_redirect_to works_path
      
      expect(flash[:error]).must_equal "Could not find work with id: -1"
    end
  end

  describe "new" do
    it "responds with success" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work with valid information accurately, and redirect" do
      work_hash = {
        work: {
          title: "Random name", 
          creator: "XFHJKDHSLFKJDKL", 
          category: "book",  
          publication_year: 2009, 
          description: "Random description"
        }
      }

      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: work_hash[:work][:title])

      expect(new_work.title).must_equal work_hash[:work][:title]
      expect(new_work.creator).must_equal work_hash[:work][:creator]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end

    it "does not create a work if the form data violates Work validations, and responds with a redirect" do
      work_hash = {
        work: {
          title: "Random name", 
          creator: "XFHJKDHSLFKJDKL", 
          category: "book",  
          description: "Random description"
        }
      }

      expect {
        post works_path, params: work_hash
      }.wont_change "Work.count"

      must_respond_with :success
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid work" do
      get edit_work_path(works(:gay).id)

      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing work" do
      get edit_work_path(-1)

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "update" do
    it "can update an existing work with valid information accurately, and redirect" do
      existing_work = works(:obama)

      updated_work_hash = {
        work: {
          title: "Wrong Title",
        }
      }

      expect {
        patch work_path(existing_work.id), params: updated_work_hash
      }.wont_change "Work.count"

      updated_work = Work.find_by(id: existing_work.id)

      expect(updated_work.title).must_equal updated_work_hash[:work][:title]

      must_respond_with :redirect
      must_redirect_to work_path(updated_work)
    end

    it "does not update any work if given an invalid id, and responds with a redirect" do
      updated_work_hash = {
        work: {
          title: "Wrong Title",
        }
      }

      invalid_work_id = -1

      patch work_path(invalid_work_id), params: updated_work_hash

      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "does not update a work if the form data violates Work validations, and responds with a redirect" do
      existing_work = works(:miller)
      existing_publication_year = existing_work.publication_year

      updated_work_hash = {
        work: {
          publication_year: 1,
        }
      }

      expect {
        patch work_path(existing_work.id), params: updated_work_hash
      }.wont_change "Work.count"

      work = Work.find_by(id: existing_work.id)

      expect(work.publication_year).must_equal existing_publication_year
      must_respond_with :redirect
      must_redirect_to work_path(work.id)
    end
  end

  describe "destroy" do

    it "destroys the work instance in db when work exists, then redirects" do

      expect {
        delete work_path(works(:miller))
      }.must_change "Work.count", 1

      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "does not change the db when the work does not exist, then responds with " do
      invalid_work_id = -1

      delete work_path(invalid_work_id)

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "upvote" do
    before do
      @work = works(:westover)
      @user = User.create!(username: "New")


    end

    it "votes when user is logged in and vote is unique" do
      login_data = {
        user: {
          username: @user.username
        }
      }

      post login_path, params: login_data

      expect{
        post upvote_path(@work.id)
      }.must_change "Vote.count", 1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "user cannot vote when they are not logged in" do

      expect{
        post upvote_path(@work.id)
      }.wont_change "Vote.count"

      expect(flash[:warning]).must_equal "Please log in to vote"
      must_respond_with :redirect
      must_redirect_to work_path(@work.id)

    end

    it "user cannot vote when they have already voted for that media" do
      login_data = {
        user: {
          username: @user.username
        }
      }

      post login_path, params: login_data
      post upvote_path(@work.id)

      expect{
        post upvote_path(@work.id)
      }.wont_change "Vote.count"

      expect(flash[:error]).must_equal "Unable to vote twice for the same piece of media"
      must_respond_with :redirect
      must_redirect_to work_path(@work.id)
    end

  end

end
