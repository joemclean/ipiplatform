require 'spec_helper'

describe Resource do
  describe 'validations' do
    it 'should have a name' do
      resource = FactoryGirl.build_stubbed(:resource, name: nil)

      expect(resource.valid?).to be_false
    end

    it 'should have a description' do
      resource = FactoryGirl.build_stubbed(:resource, description: nil)

      expect(resource.valid?).to be_false
    end

    it 'should have a full description' do
      resource = FactoryGirl.build_stubbed(:resource, full_description: nil)

      expect(resource.valid?).to be_false
    end

    it 'should have a link' do
      resource = FactoryGirl.build_stubbed(:resource, link: nil)

      expect(resource.valid?).to be_false
    end

    it 'should have a source' do
      resource = FactoryGirl.build_stubbed(:resource, source: nil)

      expect(resource.valid?).to be_false
    end

    it 'should have an associated user' do
      resource = FactoryGirl.build_stubbed(:resource, user_id: nil)

      expect(resource.valid?).to be_false
    end

    it 'should be created with FactoryGirl' do
      resource = FactoryGirl.build_stubbed(:resource)

      expect(resource.valid?).to be_true
    end
  end
end
