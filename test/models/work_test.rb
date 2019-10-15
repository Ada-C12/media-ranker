require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "book", title: "Cool Book", creator: "Cooler Author", description: "Here is a desc",publication_year: 1993)
  }

  it "can be instantiated" do
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    new_work.save
    [:category, :title, :creator, :description,:publication_year].each do |field|
      expect(new_work).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes" do
      # new_work.save
      # new_vote1 = Vote.create(work_id: new_work.id, user_id: 1)
      # new_vote2 = Vote.create(work_id: new_work.id, user_id: 2)
      # puts "HERE IS IT #{new_vote1.work_id}"
      # puts "HERE IS IT #{new_vote2.work_id}"
      # puts "HERE IS IT #{new_work.title}"

      # expect(new_work.votes.count).must_equal 2
      # new_work.votes.each do |vote|
      #   expect(vote).must_be_instance_of Vote
      # end
    end
  end

  describe "validations" do
    it "must have a category" do
      new_work.category = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      new_work.title = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a description" do
      new_work.description = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :description
      expect(new_work.errors.messages[:description]).must_equal ["can't be blank"]
    end  
    
    it "must have a publication_year" do
      new_work.publication_year = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["can't be blank"]
    end     
  end

  describe "custom methods" do
  end
end
