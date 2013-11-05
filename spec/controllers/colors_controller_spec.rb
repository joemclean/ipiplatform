require 'spec_helper'

describe ColorsController do
  let (:description) { 'as in tasty carrots' }
  let (:params) { {id: @color.id, name: 'orange', description: description} }

  describe 'when not logged in' do
    it 'user should not be able to update' do
      @color = FactoryGirl.create(:color, value_proposition: FactoryGirl.create(:value_proposition))
      patch :update, params

      @color.reload

      expect(@color.name).to eql('color_name')
      expect(@color.description).to eql('color_description')
    end
  end

  describe '#update' do
    before :each do
      ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

      @color = FactoryGirl.create(:color, value_proposition: FactoryGirl.create(:value_proposition))
    end

    it 'should update colors' do
      patch :update, params

      @color.reload

      expect(@color.name).to eql('orange')
      expect(@color.description).to eql(description)
    end
  end
end