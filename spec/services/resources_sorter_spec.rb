require 'spec_helper'

describe ResourcesSorter do
  describe 'sort' do
    it 'inserts each resource param in list at param index plus one' do
      resource1 = FactoryGirl.build(:resource, id: 5, position: 1)
      resource2 = FactoryGirl.build(:resource, id: 6, position: 2)
      resource3 = FactoryGirl.build(:resource, id: 7, position: 3)
      Resource.any_instance.stub(:save)
      subject.stub(:item_to_find).and_return(resource3, resource1, resource2)

      subject.sort( [7,5,6] )
      resource1.position.should eql 2
      resource2.position.should eql 3
      resource3.position.should eql 1
    end

  end
end
