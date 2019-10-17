require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = Work.new(title: 'test work')
    end
    
    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal true
    end
    
    it 'is invalid without a title' do 
      @work.title = nil
      
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end
    
    it 'is invalid if the title is not unique' do
      new_work = Work.new(title: 'test work')
      new_work.save
      @work.title = new_work.title
      @work.save            
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end
end
