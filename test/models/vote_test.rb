require "test_helper"

describe Vote do
  # let (:new_vote) {
  #   Vote.new(work_id: 1, user_id: 1)
  # }
  describe "relationships" do
    it "belongs to a work" do
      work = Work.create!(category: "movie", title: "Howl's Moving Castle", creator: "Hayao Miyazaki", publication_year: 2004, description: "Great movie")

      expect(new_vote.work).must_be_instance_of Vote
    end
  end
end
