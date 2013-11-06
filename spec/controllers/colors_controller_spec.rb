require 'spec_helper'

describe ColorsController do
  describe '#create' do
    before :each do
      @description = 'as in tasty carrots'
      @name = 'orange'
      value_proposition = FactoryGirl.create(:value_proposition, name: 'Hats and bowties', description: 'are good for events')
      @create_params = {color: {
        name: @name,
        description: @description,
      },
                        value_proposition_id: value_proposition.id
      }
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should create a color' do
        patch :create, @create_params

        @color = Color.all.first

        expect(@color.name).to eql 'orange'
        expect(@color.description).to eql @description
      end

      it 'should be able to attach associated value proposition' do
        patch :create, @create_params

        @color = Color.all.first

        expect(@color.value_proposition.name).to eql 'Hats and bowties'
        expect(@color.value_proposition.description).to eql 'are good for events'
      end
    end

    context 'as a user' do
      it 'should not be able to create a color' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        patch :create, @create_params

        expect(Color.all.count).to eql(0)
      end
    end

    context 'while not signed in' do
      it 'should not be able to create a color' do
        patch :create, @create_params

        expect(Color.all.count).to eql(0)
      end
    end
  end

  describe '#destroy' do
    before :each do
      @value_proposition = FactoryGirl.create(:value_proposition)
      @color = FactoryGirl.create(:color, value_proposition: @value_proposition)
      @destroy_params = {id: @color.id}
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should delete a color' do
        delete :destroy, @destroy_params

        expect(Color.all.count).to eql(0)
      end

      it 'should be able to detatch associated value proposition' do
        @value_proposition.colors.count.should eql(1)

        delete :destroy, @destroy_params

        expect(@value_proposition.colors.count).to eql(0)
      end
    end

    context 'as a user' do
      it 'should not be able to delete a color' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        delete :destroy, @destroy_params

        expect(Color.all.count).to eql(1)
      end
    end

    context 'while not signed in' do
      it 'should not be able to delete a color' do
        delete :destroy, @destroy_params

        expect(Color.all.count).to eql(1)
      end
    end
  end

  describe '#index' do
    before :each do
      @value_proposition = FactoryGirl.create(:value_proposition)
      @color = FactoryGirl.create(:color, value_proposition: @value_proposition)
      @get_params = {id: @color.id}
    end

    context 'as an admin user' do
      it 'should show the list of colors' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :index, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(colors_path)
      end
    end

    context 'as a user' do
      it 'should redirect the user to the root path' do
        get :index, @get_params

        response.should redirect_to new_session_path
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
      @color = FactoryGirl.create(:color, value_proposition: @value_proposition)
      @get_params = {id: @color.id}
    end

    context 'as an admin user' do
      it 'should show the requested color' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(color_path)
      end
    end

    context 'as a user' do
      it 'should show the requested color' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(color_path)
      end
    end

    context 'while not signed in' do
      it 'should show the requested color' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(color_path)
      end
    end
  end

  describe '#update' do
    before :each do
      @description = 'as in tasty carrots'
      @name = 'orange'
      other_value_proposition = FactoryGirl.create(:value_proposition, name: 'Hats and bowties', description: 'are good for events')
      @color = FactoryGirl.create(:color, value_proposition: FactoryGirl.create(:value_proposition))
      @params = {id: @color.id,
                 color: {
                   name: @name,
                   description: @description,
                 },
                 value_proposition_id: other_value_proposition.id
      }
    end
    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should update colors' do
        patch :update, @params

        @color.reload

        expect(@color.name).to eql 'orange'
        expect(@color.description).to eql @description
      end

      it 'should be able to replace associated value proposition' do
        patch :update, @params

        @color.reload

        expect(@color.value_proposition.name).to eql 'Hats and bowties'
        expect(@color.value_proposition.description).to eql 'are good for events'
      end
    end

    context 'as a user' do
      it 'should not be able to update a color' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        patch :update, @params

        @color.reload

        expect(@color.name).to eql('color_name')
        expect(@color.description).to eql('color_description')
      end
    end

    context 'while not signed in' do
      it 'should not be able to update a color' do
        patch :update, @params

        @color.reload

        expect(@color.name).to eql('color_name')
        expect(@color.description).to eql('color_description')
      end
    end
  end
end