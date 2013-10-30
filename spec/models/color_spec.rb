require 'spec_helper'

describe Color do
  describe 'validations' do
    it 'should have a name' do
      color = FactoryGirl.build(:color, name: nil)

      expect(color.valid?).to be_false
    end

    it 'should have a description' do
      color = FactoryGirl.build(:color, description: nil)

      expect(color.valid?).to be_false
    end
  end
end