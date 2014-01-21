require 'spec_helper'

describe ValueProposition do
  describe 'validations' do
    it 'should have a name' do
      value_proposition_category = FactoryGirl.build_stubbed(:value_proposition_category, name: nil)

      expect(value_proposition_category.valid?).to be_false
    end

    it 'should have a description' do
      value_proposition_category = FactoryGirl.build_stubbed(:value_proposition_category, description: nil)

      expect(value_proposition_category.valid?).to be_false
    end
  end
end