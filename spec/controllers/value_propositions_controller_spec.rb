require 'spec_helper'

describe ValuePropositionsController do
  before :each do
    @value_proposition = FactoryGirl.create(:value_proposition)
    @color = FactoryGirl.create(:color, value_proposition: @value_proposition)
    @params = {id: @value_proposition.id,
               value_proposition:
                 {name: 'Bunnies', description: 'like to eat carrots',
                  colors_attributes:
                    {'0' => {id: @color.id, name: 'orange', description: 'as in tasty carrots'}
                    }
                 }
    }
  end

  describe '#update' do
    context 'as an admin user' do
      before :each do
        Color.any_instance.stub(:update)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should update value propositions' do
        patch :update, @params

        @value_proposition.reload

        expect(@value_proposition.name).to eql('Bunnies')
        expect(@value_proposition.description).to eql('like to eat carrots')
      end

      it 'should be able to update color attributes' do
        Color.any_instance.should_receive(:update).exactly(1).times

        patch :update, @params
      end
    end

    context 'as a user' do
      it 'should not be able to update value propositions' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        ValueProposition.any_instance.should_not_receive(:update)

        patch :update, @params

        expect(@value_proposition.name).to eql 'value_proposition_name'
        expect(@value_proposition.description).to eql 'value_proposition_description'
      end
    end

    context 'while not signed in' do
      it 'should not be able to update value propositions' do
        ValueProposition.any_instance.should_not_receive(:update)

        patch :update, @params

        expect(@value_proposition.name).to eql 'value_proposition_name'
        expect(@value_proposition.description).to eql 'value_proposition_description'
      end
    end
  end


  describe '#destroy' do
    context 'as an admin user' do
      before :each do
        Color.any_instance.stub(:destroy)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should delete value propositions' do
        delete :destroy, @params

        expect(ValueProposition.all.empty?).to be_true
      end

      it 'should not be able to delete associated color(s)' do
        Color.any_instance.should_receive(:destroy).exactly(1).times

        delete :destroy, @params
      end
    end

    context 'as a user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should not delete value propositions' do
        ValueProposition.any_instance.should_not_receive(:destroy)

        delete :destroy, @params

        expect(ValueProposition.all.count).to eql 1
      end

      it 'should be able to delete associated color(s)' do
        Color.any_instance.should_not_receive(:destroy)

        delete :destroy, @params
      end
    end

    context 'while not signed in' do
      it 'should not delete value propositions' do
        ValueProposition.any_instance.should_not_receive(:destroy)

        delete :destroy, @params

        expect(ValueProposition.all.count).to eql 1
      end

      it 'should be able to delete associated color(s)' do
        Color.any_instance.should_not_receive(:destroy)

        delete :destroy, @params
      end
    end

  end

  describe '#create' do
    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should create value propositions' do
        new_params = {value_proposition: {name: 'new_value_proposition_name', description: 'new_value_proposition_description'}}

        post :create, new_params

        expect(ValueProposition.all.count).to be 2
      end
    end

    context 'as a user' do
      it 'should not create value propositions' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        ValueProposition.any_instance.should_not_receive(:create)

        post :create, @params

        expect(ValueProposition.all.count).to eql 1
      end
    end
    context 'while not signed in' do
      it 'should not create value propositions' do
        ValueProposition.any_instance.should_not_receive(:create)

        post :create, @params

        expect(ValueProposition.all.count).to eql 1
      end
    end
  end
end