require 'spec_helper'

describe ApplicationController do
  describe '#store_location' do
    context 'with fullpath as new user path' do
      it 'the `previous url` is not changed' do
        expect(subject.store_location).to eql('')

        request.stub(:fullpath).and_return(new_user_path)

        expect(subject.store_location).to be_nil
      end
    end

    context 'with fullpath as new session path' do
      it 'the `previous url` is not changed' do
        expect(subject.store_location).to eql('')

        request.stub(:fullpath).and_return(new_session_path)

        expect(subject.store_location).to be_nil
      end
    end

    context 'with fullpath related to anything else' do
      it 'the `previous url` is updated to reflect the most recent url' do
        expect(subject.store_location).to eql('')

        request.stub(:fullpath).and_return(resources_path)

        expect(subject.store_location).to eql(resources_path)
      end
    end
  end
end