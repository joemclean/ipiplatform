require 'spec_helper'

describe ResourcesController do
  describe '#create' do
    before :each do
      user = FactoryGirl.create(:user)
      yellow_value_proposition = FactoryGirl.create(:value_proposition, name: 'yellow')
      green_value_proposition = FactoryGirl.create(:value_proposition, name: 'green')

      @description = 'as in tasty carrots'
      @name = 'orange'
      @step = FactoryGirl.create(:step, id: 0)
      @create_params = {user_id: user.id,
                        value_proposition_ids: [yellow_value_proposition.id, green_value_proposition.id],
                        resource: {
                          name: @name,
                          link: 'resource_link',
                          description: @description,
                          full_description: 'resource_full_description',
                          source: 'A cool person',
                          tag_list: 'resource_tag_list',
                          step_id: @step.id
                        },
                        image: 'image.jpg'
      }
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      context 'resource is valid' do
        it 'should create a resource using resource_params' do
          patch :create, @create_params

          @resource = Resource.all.first

          expect(Resource.all.count).to eql(1)
          expect(@resource.name).to eql @name
          expect(@resource.link).to eql 'resource_link'
          expect(@resource.description).to eql @description
          expect(@resource.full_description).to eql 'resource_full_description'
          expect(@resource.source).to eql 'A cool person'
          expect(@resource.step_id).to eql @step.id
        end

        it 'should be able to attach associated tags' do
          patch :create, @create_params

          @resource = Resource.all.first

          expect(@resource.tags.count).to eql(1)
        end

        it 'should create a resource with a specific tag' do
          patch :create, @create_params

          @resource = Resource.all.first

          expect(@resource.tag_list).to eql 'resource_tag_list'
        end

        it 'should be able to attach associated image' do
          patch :create, @create_params

          @resource = Resource.all.first

          expect(@resource.image.class).to eql(ImageUploader)
        end

        it 'should redirect to resource show page' do
          patch :create, @create_params
          response.should redirect_to(resource_path(Resource.all.first))
        end
      end

      context 'resource is invalid' do
        it 'should render new resource template' do
          Resource.any_instance.stub(:valid?).and_return(false)
          patch :create, @create_params
          response.should render_template('new')
        end
      end
    end

    context 'as a user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should create a resource using resource_params' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(Resource.all.count).to eql(1)
        expect(@resource.name).to eql @name
        expect(@resource.link).to eql 'resource_link'
        expect(@resource.description).to eql @description
        expect(@resource.full_description).to eql 'resource_full_description'
        expect(@resource.source).to eql 'A cool person'
      end

      it 'should be able to attach associated tags' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(@resource.tags.count).to eql(1)
      end

      it 'should create a resource with a specific tag' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(@resource.tag_list).to eql 'resource_tag_list'
      end

      it 'should be able to attach associated image' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(@resource.image.class).to eql(ImageUploader)
      end

    end

    context 'while not signed in' do
      it 'should redirect the user' do
        patch :create, @create_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not be able to create a resource' do
        patch :create, @create_params

        expect(Resource.all.count).to eql(0)
      end
    end
  end

  describe '#destroy' do
    before :each do
      yellow_value_proposition = FactoryGirl.create(:value_proposition, name: 'yellow')
      green_value_proposition = FactoryGirl.create(:value_proposition, name: 'green')

      @resource = FactoryGirl.create(:resource)
      @resource.value_propositions = [yellow_value_proposition, green_value_proposition]

      @destroy_params = {id: @resource.id}
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        user = FactoryGirl.create(:user, is_admin: true)
        controller.stub(:current_user).and_return(user)
      end

      it 'should delete any resource' do
        delete :destroy, @destroy_params

        expect(Resource.all.count).to eql(0)
      end

      it 'should automatically delete value proposition association' do
        @resource.value_propositions.count.should eql(2)

        delete :destroy, @destroy_params

        expect(@resource.value_propositions.count).to eql(0)
      end

    end

    context 'as a user' do
      context 'with a resource owned by the user' do
        it 'should delete a resource' do
          ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
          user = FactoryGirl.create(:user)
          controller.stub(:current_user).and_return(user)

          delete :destroy, @destroy_params
          expect(Resource.all.count).to eql(0)
        end
      end

      context 'with a resource owned by someone else' do
        it 'should not be able to delete a resource' do
          ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
          delete :destroy, @destroy_params

          expect(Resource.all.count).to eql(1)
        end
      end

    end

    context 'while not signed in' do
      it 'should redirect the user' do
        delete :destroy, @destroy_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not be able to delete a resource' do
        delete :destroy, @destroy_params

        expect(Resource.all.count).to eql(1)
      end
    end
  end

  describe '#update' do
    before :each do
      @yellow_value_proposition = FactoryGirl.create(:value_proposition, name: 'yellow')
      @green_value_proposition = FactoryGirl.create(:value_proposition, name: 'green')

      @description = 'as in tasty carrots'
      @name = 'orange'
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      context 'with a resource owned by the admin' do
        before :each do
          @user = FactoryGirl.create(:user, is_admin: true)
          @resource = FactoryGirl.create(:resource, user: @user)

          @resource.value_propositions = []

          controller.stub(:current_user).and_return(@user)
          @update_params = {  id: @resource.id,
                              user_id: @user.id,
                              value_proposition_ids: [@yellow_value_proposition.id, @green_value_proposition.id],
                              resource: {
                                name: @name,
                                link: 'resource_link',
                                description: @description,
                                full_description: 'resource_full_description',
                                source: 'A cool person',
                                tag_list: 'resource_tag_list'
                              },
                              image: 'image.jpg'
          }
        end

        it 'should update any resource' do

          patch :update, @update_params

          @resource.reload

          expect(@resource.name).to eql(@name)
        end

      end

      context 'with a resource owned by another user' do
        before :each do
          @user = FactoryGirl.create(:user, is_admin: true)
          @other_user = FactoryGirl.create(:user, name: 'Bob')

          @resource = FactoryGirl.create(:resource, user: @other_user)

          @resource.value_propositions= []

          controller.stub(:current_user).and_return(@user)
          @update_params = {id: @resource.id,
                            user_id: @other_user.id,
                            value_proposition_ids: [@yellow_value_proposition.id, @green_value_proposition.id],
                            resource: {
                              name: @name,
                              link: 'resource_link',
                              description: @description,
                              full_description: 'resource_full_description',
                              source: 'A cool person',
                              tag_list: 'resource_tag_list'
                            },
                            image: 'image.jpg'
          }
        end

        it 'should update any resource' do

          patch :update, @update_params

          @resource.reload

          expect(@resource.name).to eql(@name)
        end

      end
    end

    context 'as a user' do
      before :each do
        @user = FactoryGirl.create(:user)
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        @resource = FactoryGirl.create(:resource, user: @user)

        @resource.value_propositions = []

        controller.stub(:current_user).and_return(@user)
        @update_params = {id: @resource.id,
                          user_id: @user.id,
                          value_proposition_ids: [@yellow_value_proposition.id, @green_value_proposition.id],
                          resource: {
                            name: @name,
                            link: 'resource_link',
                            description: @description,
                            full_description: 'resource_full_description',
                            source: 'A cool person',
                            tag_list: 'resource_tag_list'
                          },
                          image: 'image.jpg'
        }
      end

      context 'with a resource owned by the user' do
        it 'should update a resource' do

          patch :update, @update_params

          @resource.reload

          expect(@resource.name).to eql(@name)
        end
      end

      context 'with a resource owned by someone else' do
        it 'should not be able to update a resource' do

          other_user = FactoryGirl.create(:user, name: 'Wilson')
          other_users_resource = FactoryGirl.create(:resource, user: other_user)
          update_params = {id: other_users_resource.id,
                           user_id: other_user.id,
                           value_proposition_ids: [@yellow_value_proposition.id, @green_value_proposition.id],
                           resource: {
                             name: @name,
                             link: 'resource_link',
                             description: @description,
                             full_description: 'resource_full_description',
                             source: 'A cool person',
                             tag_list: 'resource_tag_list'
                           },
                           image: 'image.jpg'
          }

          patch :update, update_params

          expect(other_users_resource.name).to eql('resource_name')
        end
      end

    end

    context 'while not signed in' do
      before :each do
        @user = FactoryGirl.create(:user, is_admin: true)
        @resource = FactoryGirl.create(:resource, user: @user)

        @resource.value_propositions = [@yellow_value_proposition, @green_value_proposition]

        @update_params = {  id: @resource.id,
                            user_id: @user.id,
                            value_proposition_ids: [@yellow_value_proposition.id, @green_value_proposition.id],
                            resource: {
                              name: @name,
                              link: 'resource_link',
                              description: @description,
                              full_description: 'resource_full_description',
                              source: 'A cool person',
                              tag_list: 'resource_tag_list'
                            },
                            image: 'image.jpg'
        }
      end

      it 'should redirect the user' do
        patch :update, @update_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not be able to update a resource' do
        patch :update, @update_params

        expect(@resource.name).to eql('resource_name')
      end
    end
  end

  describe '#index' do
    before :each do
      resource = FactoryGirl.create(:resource)
      @get_params = {id: resource.id}
    end

    context 'as an admin user' do
      it 'should show the list of resources' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :index, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resources_path)
        assert_not_nil assigns(:resources)
      end

    end

    context 'as a user' do
      it 'should show the list of resources' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        get :index, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resources_path)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user' do
        get :index, @get_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should redirect the user to the new sessions path' do
        get :index, @get_params

        response.should redirect_to new_session_path
      end
    end
  end

  describe '#new' do

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'assigns a new resource to @resource' do
        step = FactoryGirl.create(:step, id: 0)
        get :new, {:step_id => step.id}
        assigns(:resource).should be_a_new(Resource)
        assigns(:resource).step_id.should eql(step.id)
        response.should render_template(:new)
      end
    end

    context 'as a user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should view the create-a-resource page' do
        get :new, {:step_id => 0}

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_resource_path)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user' do
        get :new, {:step_id => 0}

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not view the create-a-resource page' do
        get :new, {:step_id => 0}

        response.should redirect_to new_session_path
      end
    end
  end

  describe '#show' do
    before :each do
      @resource = FactoryGirl.create(:resource)

      @get_params = {id: @resource.id}
    end

    context 'as an admin user' do
      it 'should show the requested resource' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        controller.stub_chain(:current_user, :id).and_return(1)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resource_path)
      end
    end

    context 'as a user' do
      it 'should show the requested resource' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        controller.stub_chain(:current_user, :id).and_return(1)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resource_path)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user' do
        get :show, @get_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should redirect the user to the new sessions path' do
        get :show, @get_params

        response.should redirect_to new_session_path
      end
    end
  end

  describe "#filter" do
    before :each do
      ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      @yellow_value_proposition = FactoryGirl.create(:value_proposition, name: 'yellow')
      @yellowish_value_proposition = FactoryGirl.create(:value_proposition, name: 'yellowish')

      @resource_yellow = FactoryGirl.create(:resource,name: "resource_yellow")
      @resource_yellowish = FactoryGirl.create(:resource,name: "resource_yellowish")
      @resource_green = FactoryGirl.create(:resource,name: "resource_green")

      @resource_yellow.update({value_proposition_ids: [@yellow_value_proposition.id]})
      @resource_yellowish.update({value_proposition_ids: [@yellowish_value_proposition.id]})
    end

    context "a filter query exists" do
      it 'returns resources with the given filter' do
        post :filter, {value_proposition: "yellow"}

        assigns(:resources).should =~([@resource_yellow, @resource_yellowish])
        response.should render_template("index")
      end
    end

    context "a filter does not exist" do
      it 'returns all the resources' do
        post :filter

        assigns(:resources).should =~([@resource_yellow, @resource_yellowish, @resource_green])
        response.should render_template("index")
      end
    end

  end
end
