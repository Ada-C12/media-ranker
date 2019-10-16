require "test_helper"

describe HomepagesController do
  it "can get the homepage" do
    # temp work because spotlight pulls first record
    Work.create(category: "book", title: "Work of Art", creator: "Me", publication_year: 2019, description: "This is a description")
    
    puts "Works"
    p Work.all
    get root_path
    
    must_respond_with :success
  end
end
