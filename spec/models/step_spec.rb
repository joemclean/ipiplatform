require 'spec_helper'

describe Step do
  describe 'validations' do
    it "should have a name" do
      step = FactoryGirl.build_stubbed(:step, name: nil)
      expect(step.valid?).to be_false
    end
  end

  describe 'associations' do
    it { should belong_to(:value_proposition) }

    it 'should have and belong to many resources' do
      Step.reflect_on_association(:resources).macro.should == :has_and_belongs_to_many
    end
  end

  describe '#add_resource' do
    it 'should add a new resource to the step' do
      step = Step.new
      resource = Resource.new
      step.add_resource(resource)
      step.resources.last.should == resource
    end
  end
end
