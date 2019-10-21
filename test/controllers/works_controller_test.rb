require "test_helper"

describe WorksController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  describe "index" do
    it "can get a list of all the works" do 
      get works_path
      
      must_respond_with :success
    end
  end
  
  # show
  describe "show" do
    it "can get a work" do
      work = Work.find_by(creator: "Wanda Gag")
      
      get work_path(work.id)
      
      must_respond_with :success
    end
  end
  
  # create
  describe "create" do
    it "can create a new work" do
      params = {
        category: "album",
        title: "New work",
        creator: "New creator",
        publication_year: 2000,
        description: "Cool new work"
      }
      expect{ Work.create(params) }.must_differ "Work.count", 1
      
      work = Work.find_by(title: "New work", category: "album")
      expect(work.creator).must_equal "New creator"
      expect(work.publication_year).must_equal 2000
      expect(work.description).must_equal "Cool new work"
      
    end
  end
  
  # destroy
  describe "destroy" do
    it "can delete a work" do
      works = Work.all
      work = Work.find_by(creator: "Wanda Gag")
      
      expect{ delete work_path(work.id)}.must_differ "Work.count", -1
    end
    
    it "responds with an error when attempting to view a deleted work" do
      work = Work.find_by(creator: "Wanda Gag")
      id = work.id
      
      delete work_path(id)
      
      expect { get work_path(id) }
      must_respond_with :redirect
    end
    
    it "deletes all corresponding votes" do
      work = Work.find_by(creator: "Wanda Gag")
      votes = work.votes
      
      expect(votes.length).must_equal 2
      
      delete work_path(work.id)
      votes.reload
      expect(votes.length).must_equal 0
    end
  end
end
