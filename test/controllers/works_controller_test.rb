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
    it "responds with success when fetching the edit page for an existing, valid work" do
      work = Work.last
      get edit_work_path(work.id)
      must_respond_with :success
    end
    
    it "responds with redirect when fetching the edit page for a nonexistant work" do 
      work = Work.last
      get edit_work_path(-9)
      must_respond_with :redirect
    end
  end
  
  describe "update" do 
    before do 
      @work = Work.last
      @work_hash = {
        work: {
          ref_name: @work.name,
          ref_description: @work.description,
          ref_creator: @work.creator,
          ref_category: @work.category,
          ref_publication_year: @work.publication_year,
        }
      }
    end
    
    it "upon updating, the edited field changes, but the other fields remain the same" do
      id = @work.id
      test_params = {work: { name: "Testy Name" } }
      
      #name
      patch work_path(id), params: test_params
      expect(Work.find(id).name).must_equal test_params[:work][:name]
      
      expect(Work.find(id).description).must_equal @work_hash[:work][:ref_description]
      expect(Work.find(id).creator).must_equal @work_hash[:work][:ref_creator]
      expect(Work.find(id).category).must_equal @work_hash[:work][:ref_category]
      expect(Work.find(id).publication_year).must_equal @work_hash[:work][:ref_publication_year]
      
      #if additional time, add more tests that check that as a single field changes, the others remain the same 
      ##description
      ##creator
      ##category      
      ##publication_year
    end
    
    it "upon updating, the count remains the same" do
      id = @work.id
      test_params = {work: { name: "Testy Name" } }
      expect{patch work_path(id), params: test_params}.wont_change "Work.count"
      
      must_respond_with :redirect
    end
  end
  
  describe "destroy" do
    it "verifies that the count of works decreases by 1 upon deletion and the site redirects" do
      test_work = Work.last
      expect {delete work_path(Work.last.id)}.must_change "Work.count", -1
      
      must_respond_with :redirect
    end
    
    it "verifies that the count of total votes in unaffected by the deletion of a work" do
      test_work = Work.last
      expect {delete work_path(Work.last.id)}.wont_change "Vote.count"
    end
    
    it "does not change the count of works if the work id is invalid" do
      test_work = Work.last
      expect{delete work_path(-9)}.wont_change "Work.count"
    end
  end
  
  describe "main" do
    it "spotlight is the highest upvoted work across all categories" do
      expected_work_id = 1
      #atm, checked using the terminal
    end
    
    it "spotlight shows only a single upvoted work if two votes have an equally high number of votes" do
      Vote.create(work_id: 4, user_id: 4)
      #atm, checked using the terminal
      
    end
    
    it "top <category> shows a maximum of 10 works for a given category" do
      Work.create(name: "Vanessa", category: "movie")
      Work.create(name: "Sontee Jenkins", category: "movie")
      Work.create(name: "Grace Rossiter", category: "movie")
      Work.create(name: "Margie Hendricks", category: "movie")
      Work.create(name: "Kreela", category: "movie")
      Work.create(name: "Angela", category: "movie")
      Work.create(name: "Sam Fuller", category: "movie")
      Work.create(name: "Erika Murphy", category: "movie")
      Work.create(name: "Angela Abar", category: "movie")
      Work.create(name: "Janine Davis", category: "movie")
      
      #expect @top_movies.count == 10
      #atm checked using the terminal
    end
    
    
  end
  
end
