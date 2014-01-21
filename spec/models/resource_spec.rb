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


    context 'for non-production environment' do

      before :each do
        FakeFS.activate!
        FakeFS::File.should_receive(:chmod) #this is needed or you will get an exception
        @resource = FactoryGirl.build(:resource)

      end

      after :each do
        FakeFS.deactivate!
      end

      it 'should upload image to dev-bucket on s3' do
        File.open('test_image.jpg', 'w') do |f|
          f.puts('foo') # this is required or uploader_test.file.url will be nil
        end

        @resource.image = File.open('test_image.jpg')
        @resource.save!
        @resource.image.url.should match /.*\/dev-bucket-ipi.*uploads\/image\/resource\/1-resource_name/ #test to make sure that it is not production-bucket
      end

      it 'should upload a file to dev-bucket on s3' do
        File.open('test_file.txt', 'w') do |f|
          f.puts('foo') # this is required or uploader_test.file.url will be nil
        end

        @resource.file = File.open('test_file.txt')
        @resource.save!
        @resource.file.url.should match /.*\/dev-bucket-ipi.*uploads\/file\/resource\/1-resource_name/ #test to make sure that it is not production-bucket
      end

      context "file is uploaded/present" do
        it 'should return the file s3 url' do
          File.open('test_file.txt', 'w') do |f|
            f.puts('foo') # this is required or uploader_test.file.url will be nil
          end

          @resource.file = File.open('test_file.txt')
          @resource.save!
          @resource.file_name.should match /.*\/dev-bucket-ipi.*uploads\/file\/resource\/1-resource_name/ #test to make sure that it is not production-bucket
        end
      end
    end
  end
end
