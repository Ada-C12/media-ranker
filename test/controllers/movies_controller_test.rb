require "test_helper"

describe MoviesController do
  it "must get index" do
    get movies_index_url
    must_respond_with :success
  end

end
