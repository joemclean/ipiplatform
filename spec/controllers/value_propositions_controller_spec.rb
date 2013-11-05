require 'spec_helper'

describe ValuePropositionsController do
  describe '#update' do

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

    context 'while not signed in' do
      it 'should not be able to update' do
        patch :update, @params

        expect(@value_proposition.name).to eql 'value_proposition_name'
        expect(@value_proposition.description).to eql 'value_proposition_description'
      end
    end

    context 'while signed in' do
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

      it 'should call to update color attributes' do
        Color.any_instance.should_receive(:update).exactly(1).times

        patch :update, @params
      end
    end
  end

end