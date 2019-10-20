require "test_helper"

describe User do
  describe "validation" do
    before do
      # Arrange
      @user = User.new(username:'bob')
    end
    
    it 'is valid when all fields are present' do
      # Act
      result = @user.valid?
      # Assert
      expect(result).must_equal true
    end
    
    it 'is invalid without a username' do 
      @user.username = nil 
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end
    
    it 'is invalid if the name is not unique' do
      new_user = User.new(username: 'jkgk')
      new_user.save
      @user.username = new_user.username
      @user.save            
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end
  end

  describe 'relations' do 
    it 'has votes' do
      @username.votes.each do |vote|
        expect(vote).must_be_instance of Vote
      end
    end

    it "has many works" do
      @username.works.each do |work|
        expect(work).must_be_instance of Work

      end
    end
  end  
end
