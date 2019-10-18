require "test_helper"

describe Vote do
  describe 'validations' do
  before do
    work = works(:hello)
    user = users(:georgina)
    @vote = Vote.new(date: Time.parse("Thu Nov 29 14:33:20 2019"), user_id: user.id, work_id: work.id)
  end

    it 'is valid when all fields are present' do
      expect(@vote.valid?).must_equal true
    end

    it "will have the required fields" do
      [:date, :user_id, :work_id].each do |field|
        expect(@vote).must_respond_to field
      end
    end
  end
end
