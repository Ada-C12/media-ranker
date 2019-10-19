require "test_helper"

describe WorksController do
  
  let (:yml) { let_yml_superhash }
  let (:album1) { yml[:album1] }
  let (:ctrller) { WorksController.new }
  
  describe "INDEX" do
    
    it "must get index" do
      get works_path
      must_respond_with :success
    end
    
  end
  
  describe "NEW" do
    
    it "can get page for adding a new work" do
      get new_work_path
      must_respond_with :success
    end
    
  end
  
  describe "CREATE" do
    
    it "Can create valid Work object, with correct attribs, and see flash when redirected" do
      new_book_params = { work:{category:"book", title:"catch22", creator:"some guy", published_year:1980, description:"hilarious"} }
      expect{post works_path, params: new_book_params}.must_differ "Work.count", 1
      
      db_book = Work.last
      assert(db_book.category == "book")
      assert(db_book.title == "catch22")
      assert(db_book.creator == "some guy")
      assert(db_book.published_year == 1980)
      assert(db_book.description == "hilarious")
      
      assert(flash[:success] == "Successfully created #{db_book.category}: #{db_book.title}")
      must_redirect_to work_path(db_book.id)
    end
    
    it "If bogus inputs, won't create Work obj, but will render same page with flash msgs" do
      bad_category1 = { work:{category:"GARBAGE", title:"ok", creator:"ok", published_year:123, description:"ok"} }
      bad_category2 = { work:{category:nil, title:"ok", creator:"ok", published_year:123, description:"ok"} }
      bad_title1 = { work:{category:"album", title:nil, creator:"ok", published_year:123, description:"ok"} }
      bad_title2 = { work:{category:"album", title:album1.title, creator:"ok", published_year:123, description:"ok"} }
      bad_pub_year1 = { work:{category:"album", title:"ok", creator:"ok", published_year:nil, description:"ok"} }
      set_of_bad_params = [ bad_category1, bad_category2, bad_title1, bad_title2, bad_pub_year1]
      
      current_works_qty = Work.count
      
      set_of_bad_params.each do |bad_params|
        expect{post works_path, params: bad_params}.must_differ "Work.count", 0
        must_respond_with :success
        assert(flash.now[:error] == "Unsuccessful save:")
        # did not feel like testing the individual messages, I just want to know they exist
        assert(flash.now[:error_msgs])
      end
      
      
    end
    
  end
  
  describe "SHOW" do
    
    it "can show valid work's individual page" do
      get work_path(id: album1.id)
      must_respond_with :success
    end
    
    it "if work invalid, send to nope_path with flash msg" do
      get work_path(id: -666)
      must_redirect_to nope_path 
      assert(flash[:error] == "That book/album/movie does not exist in our database. Womp womp!")
    end
    
  end
  
  describe "EDIT" do
    
    it "can show correct page given valid work id" do
      get edit_work_path(id: album1.id)
      must_respond_with :success
    end
    
    it "if invalid work id, " do
      get edit_work_path(id: -666)
      must_redirect_to nope_path
      assert(flash[:error] == "Can't let you edit something that doesn't exist. A-doy!")
    end
    
  end
  
  describe "UPDATE" do
    
    it "" do
    end
    
    it "" do
    end
    
  end
  
  describe "DESTROY" do
    
    it "" do
    end
    
    it "" do
    end
    
  end
  
end
