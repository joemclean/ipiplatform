require 'spec_helper'
require 'fakefs/spec_helpers'
require 'support/fog_helper'

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

    it 'should have a value proposition category it belongs to' do
      color = FactoryGirl.build_stubbed(:color, value_proposition_category: nil)

      expect(color.valid?).to be_false
    end
  end

  describe "#save" do
    include FakeFS::SpecHelpers

    before :each do
      @value_proposition_category = FactoryGirl.create(:value_proposition_category)
      @color_test = FactoryGirl.build(:color, value_proposition_category: @value_proposition_category)
    end

    context 'for non-production environment' do
      it 'should upload image to dev-bucket on s3' do
        FakeFS.activate!
        FakeFS::File.should_receive(:chmod) #this is needed or you will get an exception
        File.open('test_image.jpg', 'w') do |f|
          f.puts('foo') # this is required or uploader_test.file.url will be nil
        end

        @color_test.image = File.open('test_image.jpg')
        @color_test.save!
        @color_test.image.url.should match /.*\/dev-bucket-ipi.*uploads\/image\/color\/1-color_name/ #test to make sure that it is not production-bucket
        FakeFS.deactivate!
      end
    end
  end
end
