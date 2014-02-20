require 'spec_helper'

describe StepsSorter do
  describe 'sort' do
    it 'inserts each step param in list at param index plus one' do
      step1 = FactoryGirl.build(:step, id: 5, position: 1)
      step2 = FactoryGirl.build(:step, id: 6, position: 2)
      step3 = FactoryGirl.build(:step, id: 7, position: 3)
      Step.any_instance.stub(:save)
      subject.stub(:item_to_find).and_return(step3, step1, step2)

      subject.sort( [7,5,6] )
      step1.position.should eql 2
      step2.position.should eql 3
      step3.position.should eql 1
    end

  end
end
