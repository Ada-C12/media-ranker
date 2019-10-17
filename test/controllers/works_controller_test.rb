require "test_helper"

describe WorksController do
  describe "index" do
    it "can get the index path" do
      get works_path

      must_respond_with :success
    end

    it "can get the root path" do
      get root_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid task" do
      get work_path(works(:monae).id)

      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      get work_path(-1)

      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      work_hash = {
        work: {
          category: "book",
          title: "To Kill a Mockingbird",
          creator: "Harper Lee",
          publication_year: 1960,
          description: "A classic book",
        },
      }

      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.publication_year).must_equal work_hash[:work][:publication_year]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      get edit_work_path(works(:test).id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a non-existent task" do
      get edit_work_path(-1)

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "update" do
    before do
      @updated_work = {
        work: {
          title: "An updated work test", description: "I'm an updated work",
        },
      }
    end
    it "can update an existing work" do
      work_id = works(:test).id
      patch work_path(work_id), params: @updated_work

      edited_work = Work.find_by(id: work_id)
      expect(edited_work.title).must_equal @updated_work[:work][:title]
      expect(edited_work.description).must_equal @updated_work[:work][:description]
    end

    it "will redirect to the list of tasks if given an invalid ID" do
      # Your code here
      work_id = -1
      patch work_path(work_id), params: @updated_work

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end

  describe "destroy" do
    it "can delete an existing work" do
      expect {
        delete work_path(works(:monae).id)
      }.must_change "Work.count", 1

      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "must respond with 'not found' if given an invalid ID" do
      work_id = 12345

      delete work_path(work_id)

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end
end
