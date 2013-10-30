require 'spec_helper'

describe ValueProposition do
  describe 'validations' do
    it 'should have a name' do
      value_proposition = FactoryGirl.build(:value_proposition, name: nil)

      expect(value_proposition.valid?).to be_false
    end

    it 'should have a description' do
      value_proposition = FactoryGirl.build(:value_proposition, description: nil)

      expect(value_proposition.valid?).to be_false
    end
  end
end