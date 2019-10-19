require "test_helper"

describe WorksController do
  let (:work) {
    Work.create(category: "test category", title: "sample title",creator: "sample creator", publication_year: 2019 , description:"sample description")
  }
  
  describe "index" do
    it "responds with success when going to the index work page" do
      get works_path
      must_respond_with :success
      #expect(Work.count).must_equal 0
    end
  end
  
  describe "show" do
    it "can get a valid work" do
      get work_path(id: work.id)
      must_respond_with :success
    end
    
    it "will redirect for an invalid work" do
      get work_path(-1)
      must_respond_with :redirect
    end
  end
end
