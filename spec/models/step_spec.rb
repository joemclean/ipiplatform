require 'spec_helper'

describe Step do
  describe 'validations' do
    it "should have a name" do
      step = FactoryGirl.build_stubbed(:step, name: nil)
      expect(step.valid?).to be_false
    end
  end
  it "should respond to resources" do
    step = FactoryGirl.build(:step)
    resource = FactoryGirl.build(:resource)
    step.resources=[resource]
    expect(step).to have_many(:resources)
  end
end
