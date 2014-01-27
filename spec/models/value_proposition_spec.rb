require 'spec_helper'
require 'fakefs/spec_helpers'
require 'support/fog_helper'

describe ValueProposition do
  describe 'create' do
    it 'should have a name' do
      value_proposition = FactoryGirl.build_stubbed(:value_proposition, name: nil)

      expect(value_proposition.valid?).to be_false
    end

    it 'should have a description' do
      value_proposition = FactoryGirl.build_stubbed(:value_proposition, description: nil)

      expect(value_proposition.valid?).to be_false
    end

    it 'should have a value proposition category it belongs to' do
      value_proposition = FactoryGirl.build_stubbed(:value_proposition, value_proposition_category: nil)

      expect(value_proposition.valid?).to be_false
    end
  end

  describe "#save" do
    include FakeFS::SpecHelpers

    before :each do
      @value_proposition_category = FactoryGirl.create(:value_proposition_category)
      @value_proposition_test = FactoryGirl.build(:value_proposition, value_proposition_category: @value_proposition_category)
    end

    context 'for non-production environment' do
      it 'should upload image to dev-bucket on s3' do
        FakeFS.activate!
        FakeFS::File.should_receive(:chmod) #this is needed or you will get an exception
        File.open('test_image.jpg', 'w') do |f|
          f.puts('foo') # this is required or uploader_test.file.url will be nil
        end

        @value_proposition_test.image = File.open('test_image.jpg')
        @value_proposition_test.save!
        @value_proposition_test.image.url.should match /.*\/dev-bucket-ipi.*uploads\/image\/value_proposition\/1-value_proposition_name/ #test to make sure that it is not production-bucket
        FakeFS.deactivate!
      end
    end
  end
end
