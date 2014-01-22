require 'spec_helper'

describe ValuePropositionCategoriesController do

  describe '#create' do
    context 'as an admin user' do
      before :each do
        @create_params = {value_proposition_category: {name: 'new_value_proposition_category_name', description: 'new_value_proposition_category_description'}}
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should create value proposition categories' do
        post :create, @create_params

        expect(ValuePropositionCategory.all.count).to be 1
      end
    end

    context 'as a user' do
      it 'should not create value proposition categories' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        ValuePropositionCategory.any_instance.should_not_receive(:create)

        post :create, @create_params

        expect(ValuePropositionCategory.all.count).to eql 0
      end
    end
    context 'while not signed in' do
      it 'should not create value proposition categories' do
        ValuePropositionCategory.any_instance.should_not_receive(:create)

        post :create, @create_params

        expect(ValuePropositionCategory.all.count).to eql 0
      end
    end
  end

  describe '#destroy' do
    before :each do
      @value_proposition_category = FactoryGirl.create(:value_proposition_category)
      @color = FactoryGirl.create(:color, value_proposition_category: @value_proposition_category)
      @destroy_params = {id: @value_proposition_category.id,
                         value_proposition_category:
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

      it 'should delete value proposition categories' do
        delete :destroy, @destroy_params

        expect(ValuePropositionCategory.all.empty?).to be_true
      end

      it 'should redirect to value proposition categories index' do
        delete :destroy, @destroy_params

        response.should redirect_to value_proposition_categories_path
      end

      it 'should be able to delete associated color(s)' do
        Color.any_instance.should_receive(:destroy).exactly(1).times

        delete :destroy, @destroy_params
      end
    end

    context 'as a user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should not delete value proposition categories' do
        ValuePropositionCategory.any_instance.should_not_receive(:destroy)

        delete :destroy, @destroy_params

        expect(ValuePropositionCategory.all.count).to eql 1
      end

      it 'should not be able to delete associated color(s)' do
        Color.any_instance.should_not_receive(:destroy)

        delete :destroy, @destroy_params
      end
    end

    context 'while not signed in' do
      it 'should not delete value proposition categories' do
        ValuePropositionCategory.any_instance.should_not_receive(:destroy)

        delete :destroy, @destroy_params

        expect(ValuePropositionCategory.all.count).to eql 1
      end

      it 'should not be able to delete associated color(s)' do
        Color.any_instance.should_not_receive(:destroy)

        delete :destroy, @destroy_params
      end
    end

  end

  describe '#index' do
    before :each do
      @value_proposition_category = FactoryGirl.create(:value_proposition_category)
      @index_params = {id: @value_proposition_category.id}
    end

    context 'as an admin user' do
      it 'should show value proposition categories' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :index, @index_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_categories_path)
        assigns(:value_proposition_categories).should_not be_nil
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
      @value_proposition_category = FactoryGirl.create(:value_proposition_category)
      @get_params = {id: @value_proposition_category.id}
    end

    context 'as an admin user' do
      it 'should show the requested value proposition category' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_category_path)
      end
    end

    context 'as a user' do
      it 'should show the requested value proposition category' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_category_path)
      end
    end

    context 'while not signed in' do
      it 'should show the requested value proposition category' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_category_path)
      end
    end
  end

  describe '#update' do
    before :each do
      @value_proposition_category = FactoryGirl.create(:value_proposition_category)
      @color = FactoryGirl.create(:color, value_proposition_category: @value_proposition_category)
      @params = {id: @value_proposition_category.id,
                 value_proposition_category:
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

      it 'should update value proposition categories' do
        patch :update, @params

        @value_proposition_category.reload

        expect(@value_proposition_category.name).to eql('Bunnies')
        expect(@value_proposition_category.description).to eql('like to eat carrots')
      end

      it 'should be able to update color attributes' do
        Color.any_instance.should_receive(:update).exactly(1).times

        patch :update, @params
      end
    end

    context 'as a user' do
      it 'should not be able to update value proposition categories' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        ValuePropositionCategory.any_instance.should_not_receive(:update)

        patch :update, @params

        expect(@value_proposition_category.name).to eql 'value_proposition_category_name'
        expect(@value_proposition_category.description).to eql 'value_proposition_category_description'
      end
    end

    context 'while not signed in' do
      it 'should not be able to update value proposition categories' do
        ValuePropositionCategory.any_instance.should_not_receive(:update)

        patch :update, @params

        expect(@value_proposition_category.name).to eql 'value_proposition_category_name'
        expect(@value_proposition_category.description).to eql 'value_proposition_category_description'
      end
    end
  end
end