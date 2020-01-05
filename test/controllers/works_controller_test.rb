require "test_helper"

describe WorksController do
  let (:work) {
    Work.create title: "My Life Story", category: "movie", creator: "Jones Smith", publication_year: "2019", description: "The greatest movie of all time. It was my favorite movie. I was totally taken by this movie."
  }
  describe "index" do
    it "should successfuly reach index" do
      get works_path
      must_respond_with :success
    end

    it "should retrieve a collection of all works" do
      works = Work.all
      expect(works_path.length).must_equal works.length
    end

  end

  describe "show" do
    it "can display a valid work" do
      get works_path(work)
      must_respond_with :success
    end

    it "should redirect for an invalid work" do
      # get works_path(-1)
    end
  end

  describe "new" do
  end

  describe "create" do
  end

  describe "edit" do
  end

  describe "update" do
  end

  describe "destroy" do
  end
end
