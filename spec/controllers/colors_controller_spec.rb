require 'spec_helper'

describe ColorsController do
  before :each do
    @description = 'as in tasty carrots'
    @color = FactoryGirl.create(:color, value_proposition: FactoryGirl.create(:value_proposition))
    @params = {id: @color.id, name: 'orange', description: @description, color: @color}
  end

  describe 'when not logged in' do
    it 'user should not be able to update' do
      patch :update, @params

      @color.reload

      expect(@color.name).to eql('color_name')
      expect(@color.description).to eql('color_description')
    end
  end

  describe 'when logged in' do
    before :each do
      ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
    end

    context '#update' do
      it 'should update colors' do
        # pending
      end
    end
  end
end