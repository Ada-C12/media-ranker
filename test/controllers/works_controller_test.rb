require "test_helper"

describe WorksController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  describe "fixtures verification" do 
    it "verifies that work fixtures are functional" do
      expect(Work.count).must_equal 5
    end
  end
  
  describe "new" do
    it "responds with success because a new work can be created" do
      get new_work_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    before do 
      @name = "Testy Album"
      @work_hash = {
        work: {
          name: @name,
          description: "Instance of work to use for testing",
          creator: "Muahaha",
          category: "album",
          publication_year: 2016
        }
      }
      
    end
    
    it "creating a new work increases the total number of work" do
      name = @name
      expect {post works_path, params: @work_hash }.must_change "Work.count", 1
      
      work = Work.find_by(name: name)
      expect(work.name).must_equal @work_hash[:work][:name]
      
    end
  end
  
  describe "index" do
    it "index lists all works, responds with success" do
      works_in_fixtures = 5
      get works_path
      must_respond_with :success
      assert_equal works_in_fixtures, Work.count
    end
    
    it "index is empty if no instances of work exist, still responds with success" do
      Work.destroy_all
      get users_path
      must_respond_with :success
      assert_equal 0, Work.count
    end
  end
  
  describe "edit" do
  end
  
  describe "update" do 
  end
  
  describe "destroy" do
  end
  
end
