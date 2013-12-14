require 'spec_helper'

describe Color do
  describe 'create' do
    it 'should have a name' do
      color = FactoryGirl.build_stubbed(:color, name: nil)

      expect(color.valid?).to be_false
    end

    it 'should have a description' do
      color = FactoryGirl.build_stubbed(:color, description: nil)

      expect(color.valid?).to be_false
    end

    it 'should have a value proposition it belongs to' do
      color = FactoryGirl.build_stubbed(:color, value_proposition: nil)

      expect(color.valid?).to be_false
    end

    it 'should have an image!' do
      color = FactoryGirl.build_stubbed(:color, image: nil)

      expect(color.valid?).to be_false
    end
  end
end