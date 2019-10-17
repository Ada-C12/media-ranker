require "test_helper"

describe Work do
  it "can be instantiated" do
    work = works(:movie)
    expect(work.valid?).must_equal true
  end
end
