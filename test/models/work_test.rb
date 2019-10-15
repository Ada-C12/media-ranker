require "test_helper"

describe Work do

  describe 'relations' do
    
  end

  describe 'custom methods' do
    describe 'top_ten' do
      it 'returns ten books' do #later will return top ten books
        test_list = Work.top_ten("album")

        expect(test_list.count).must_equal 10
      end
    end
  end

end
