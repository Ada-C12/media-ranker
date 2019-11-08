require "test_helper"

describe WorksController do
  # describe "Logged in users" do
  #   it "gives back a successful response" do
  #     # Arrange
  #     # ... Nothing right now!

  #     # Act
  #     # Send a specific request... a GET request to the path "/books"
  #     get books_path

  #     # Assert
  #     # The response was OK!
  #     must_respond_with :success
  #   end

  #   it "gives back a 404 if there are no books available" do

  #     # Arrange
  #     # Insert some code here that destroys all of the books in the database...

  #     # Act
  #     # get "/books"
  #     get books_path

  #     # Assert
  #     # must_respond_with :missing
  #   end
  # end

  describe "Guest users" do
    # we allow only the book index page for our guest users
    # so we'll want to verify the redirect to root and message for these
    it "cannot remove a book" do
      #Arrange
      work = works(:wind)
      #Act
      delete work_path(work.id)
      #Assert
      must_redirect_to root_path
      expect(flash[:error]).wont_be_nil
    end
  end
end
