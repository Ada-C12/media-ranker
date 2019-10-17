require "test_helper"

describe User do

  before do
    @user = User.new(name: "Leta LeStrange")
  end
  
it "can be instantiated" do
  user = User.create(name: "Hello I am Raccoon")

  expect(user.valid?).must_equal true
end

describe 'validations' do
  it 'is valid when all fields are present' do
    # Act
    result = @user.valid?

    # Assert
    expect(result).must_equal true
  end

  it 'is invalid without a name' do
    @user.name = nil

    expect(@user.valid?).must_equal false
    expect(@user.errors.messages).must_include :name
  end
end

end
