require 'spec_helper'
require 'fakefs/spec_helpers'
require 'support/fog_helper'

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

    it 'does not require an image' do
      resource = FactoryGirl.build_stubbed(:resource, image: nil)

      expect(resource.valid?).to be_true
    end

    it 'should be created with FactoryGirl' do
      resource = FactoryGirl.build_stubbed(:resource)

      expect(resource.valid?).to be_true
    end
  end

  describe "#save" do
    include FakeFS::SpecHelpers

    before :each do
      @resource = FactoryGirl.build(:resource)
    end

    context 'for non-production environment' do
      it 'should upload image to dev-bucket on s3' do
        FakeFS.activate!
        FakeFS::File.should_receive(:chmod) #this is needed or you will get an exception
        File.open('test_image.jpg', 'w') do |f|
          f.puts('foo') # this is required or uploader_test.file.url will be nil
        end

        @resource.image = File.open('test_image.jpg')
        @resource.save!
        @resource.image.url.should match /.*\/dev-bucket-ipi.*uploads\/image\/resource\/1-resource_name/ #test to make sure that it is not production-bucket
        FakeFS.deactivate!
      end
    end

  end
end
