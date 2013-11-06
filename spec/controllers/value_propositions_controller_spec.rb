require 'spec_helper'

describe ValuePropositionsController do

  describe '#create' do
    context 'as an admin user' do
      before :each do
        @create_params = {value_proposition: {name: 'new_value_proposition_name', description: 'new_value_proposition_description'}}
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should create value propositions' do
        post :create, @create_params

        expect(ValueProposition.all.count).to be 1
      end
    end

    context 'as a user' do
      it 'should not create value propositions' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        ValueProposition.any_instance.should_not_receive(:create)

        post :create, @create_params

        expect(ValueProposition.all.count).to eql 0
      end
    end
    context 'while not signed in' do
      it 'should not create value propositions' do
        ValueProposition.any_instance.should_not_receive(:create)

        post :create, @create_params

        expect(ValueProposition.all.count).to eql 0
      end
    end
  end

  describe '#destroy' do
    before :each do
      @value_proposition = FactoryGirl.create(:value_proposition)
      @color = FactoryGirl.create(:color, value_proposition: @value_proposition)
      @destroy_params = {id: @value_proposition.id,
                         value_proposition:
                           {name: 'Bunnies', description: 'like to eat carrots',
                            colors_attributes:
                              {'0' => {id: @color.id, name: 'orange', description: 'as in tasty carrots'}
                              }
                           }
      }
    end

    context 'as an admin user' do
      before :each do
        Color.any_instance.stub(:destroy)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should delete value propositions' do
        delete :destroy, @destroy_params

        expect(ValueProposition.all.empty?).to be_true
      end

      it 'should not be able to delete associated color(s)' do
        Color.any_instance.should_receive(:destroy).exactly(1).times

        delete :destroy, @destroy_params
      end
    end

    context 'as a user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should not delete value propositions' do
        ValueProposition.any_instance.should_not_receive(:destroy)

        delete :destroy, @destroy_params

        expect(ValueProposition.all.count).to eql 1
      end

      it 'should be able to delete associated color(s)' do
        Color.any_instance.should_not_receive(:destroy)

        delete :destroy, @destroy_params
      end
    end

    context 'while not signed in' do
      it 'should not delete value propositions' do
        ValueProposition.any_instance.should_not_receive(:destroy)

        delete :destroy, @destroy_params

        expect(ValueProposition.all.count).to eql 1
      end

      it 'should be able to delete associated color(s)' do
        Color.any_instance.should_not_receive(:destroy)

        delete :destroy, @destroy_params
      end
    end

  end

  describe '#index' do
    before :each do
      @value_proposition = FactoryGirl.create(:value_proposition)
      @index_params = {id: @value_proposition.id}
    end

    context 'as an admin user' do
      it 'should show value propositions' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :index, @index_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_propositions_path)
      end
    end

    context 'as a user' do
      it 'should redirect the user to the root path' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        get :index, @index_params

        response.should redirect_to root_path
      end
    end

    context 'while not signed in' do
      it 'should redirect the user to the new sessions path' do
        get :index, @get_params

        response.should redirect_to new_session_path
      end
    end
  end

  describe '#show' do
    before :each do
      @value_proposition = FactoryGirl.create(:value_proposition)
      @get_params = {id: @value_proposition.id}
    end

    context 'as an admin user' do
      it 'should show the requested value proposition' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
    end

    context 'as a user' do
      it 'should show the requested value proposition' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
    end

    context 'while not signed in' do
      it 'should show the requested value proposition' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
    end
  end

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
end