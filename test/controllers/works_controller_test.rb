require "test_helper"

describe WorksController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  
  # describe "index" do
  #   it "responds with success when there are many works saved" do
  #     work = Work.create(category: "book", title: "Work of Art", creator: "Me", publication_year: 2019, description: "This is a description")
  
  #     get works_path
  
  #     must_respond_with :success
  
  #   end
  
  #   it "responds with success when there are no works saved" do
  #     get works_path      
  
  #     must_respond_with :success
  #   end
  # end
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
    let (:work) { Work.create(category: "book", title: "Work of Art", creator: "Me", publication_year: 2019, description: "This is a description") }
    it "responds with success when showing an existing valid work" do
      id = work.id      
      
      get work_path(id)
      
      must_respond_with :success      
    end
    
    it "responds with 404 with an invalid work id" do
      id = "456456"      
      
      get work_path(id)
      
      must_respond_with :redirect      
    end
  end
  
  describe "new" do
    it "can get the new work page" do
      get new_work_path
      
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new work with valid information" do
      work_params = { work: {category: "book", title: "Created Work", creator: "Me", publication_year: 2019, description: "This is a description"} }
      
      expect{ post works_path, params: work_params }.must_differ "Work.count", 1
      
      create_work = Work.find_by(title: "Created Work")
      expect(create_work.category).must_equal work_params[:work][:category]
      expect(create_work.title).must_equal work_params[:work][:title]
      expect(create_work.creator).must_equal work_params[:work][:creator]
      expect(create_work.publication_year).must_equal work_params[:work][:publication_year]
      expect(create_work.description).must_equal work_params[:work][:description]
      
      
      must_respond_with :redirect
      must_redirect_to work_path(create_work.id)      
    end
    
    it "does not create a work if validations are note met" do
      new_work = { work: {category: nil, title: "Masterpiece", creator: "Me", publication_year: 2019, description: "This is a description"} }
      
      expect{ post works_path, params: new_work }.must_differ "Work.count", 0
      
      must_respond_with :success 
    end
  end
  
  describe "edit" do
    let (:new_work) { Work.create(category: "book", title: "Work of Art", creator: "Me", publication_year: 2019, description: "This is a description") }
    
    it "can get the edit page for an existing task" do
      new_work
      
      
      get edit_work_path(new_work.id)
      must_respond_with :success      
    end
    
    it "responds with redirect when getting the edit page for a non-existing work" do
      bad_id = "5445"
      
      get edit_work_path(bad_id)
      must_respond_with :redirect
      must_redirect_to works_path
    end
  end
  
  describe "update" do
    let (:new_work) { Work.create(category: "book", title: "Work of Art", creator: "Me", publication_year: 2019, description: "This is a description") }
    
    it "can update an existing work with valid information accurately, and redirect" do
      new_work
      expect(Work.find_by(title: "Work of Art")).must_equal new_work
      id = new_work.id
      updates = { title: "Not a Work of Art" }
      
      expect{ patch work_path(id), params: {work: updates}}.must_differ "Work.count", 0
      
      new_work.reload
      updated_work = Work.find(id)
      
      expect(updated_work.title).must_equal new_work.title
      
      must_redirect_to work_path(id)
    end
    
    it "does not update any work if given an invalid id, and responds with a 404" do
      
      bad_id = "bad-id"
      updates = { title: "Not a Work of Art" }
      
      expect{ patch work_path(bad_id), params: {work: updates}}.must_differ "Work.count", 0
      
      must_respond_with 404
    end
    
    it "does not update a work if the form data violates work validations" do
      
      work = new_work
      updates = { title: "Not a Work of Art", category: nil }
      
      expect{ patch work_path(work.id), params: {work: updates}}.must_differ "Work.count", 0
      
      must_respond_with :success 
      
    end
  end
  
  describe "destroy" do
    let (:new_work) { Work.create(category: "book", title: "Work of Art", creator: "Me", publication_year: 2019, description: "This is a description") }
    it "destroys the work instance in db when work exists, then redirects" do
      expect(new_work).must_be_instance_of Work
      
      expect { delete work_path( new_work.id ) }.must_differ "Work.count", -1
      
      must_redirect_to works_path
    end
    
    it "does not change the db when the work does not exist, then responds with " do
      bad_id = "bad-id"
      
      expect { delete work_path( bad_id ) }.must_differ "Work.count", 0
      
      must_redirect_to works_path      
      
    end
  end
  
end