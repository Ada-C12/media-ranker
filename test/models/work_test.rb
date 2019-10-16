require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(title: "cool movie", category: "movie")
  }

  it "can be instantiated" do 
    expect(new_work.valid?).must_equal true
  end 

  it "will have the required fields" do
    new_work.save
    work = Work.first
    [:title, :category].each do |field|
      expect(work).must_respond_to field
    end 
  end
end
