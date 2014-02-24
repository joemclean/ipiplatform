require 'spec_helper'

describe ResourcesController do
  before :each do
    @admin_user = FactoryGirl.create(:user, :admin)
    @user = FactoryGirl.create(:user)
  end

  describe '#create' do
    before :each do

      @description = 'as in tasty carrots'
      @name = 'orange'
      @step = FactoryGirl.create(:step, id: 0)
      @create_params = {
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
        controller.stub(:current_user).and_return(@admin_user)
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
        it 'should create a resource using resource_params without step id' do
          @create_params[:resource][:step_id] = nil
          patch :create, @create_params

          @resource = Resource.all.first
          expect(@resource.step_id).to eql nil
          response.should redirect_to(resources_path)
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

        it 'should redirect to step edit page' do
          patch :create, @create_params
          response.should redirect_to(edit_step_path(@create_params[:resource][:step_id]))
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
        controller.stub(:current_user).and_return(@user)
      end

      it 'should create a resource using resource_params' do
        patch :create, @create_params
        @resource = Resource.all.first
        expect(Resource.all.count).to eql(1)
      end

      it 'should be able to attach associated image' do
        patch :create, @create_params
        @resource = Resource.all.first
        expect(@resource.image.class).to eql(ImageUploader)
      end

    end

    context 'while not signed in' do
      before do
        controller.stub(:current_user).and_return(nil)
      end

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
      @resource = FactoryGirl.create(:resource, user_id: @user.id)
      @destroy_params = {id: @resource.id}
    end

    context 'as an admin user' do
      before :each do
        controller.stub(:current_user).and_return(@admin_user)
      end

      it 'should delete any resource' do
        request.stub(:referrer).and_return(resource_path(@resource))
        delete :destroy, @destroy_params
        expect(Resource.all.count).to eql(0)
      end

      it 'should redirect to previous url' do
        request.should_receive(:referrer).and_return(user_path(@user))
        Resource.any_instance.stub(:destroy)
        delete :destroy, @destroy_params
        response.should redirect_to(user_path(@user))
      end
    end

    context 'as a user' do
      context 'with a resource owned by the user' do
        it 'should delete a resource' do
          controller.stub(:current_user).and_return(@user)
          request.stub(:referrer).and_return(user_path(@user))
          delete :destroy, @destroy_params
          expect(Resource.all.count).to eql(0)
        end
      end

      context 'with a resource owned by someone else' do
        it 'should not be able to delete a resource' do
          Resource.any_instance.stub(:user_id).and_return(5)
          delete :destroy, @destroy_params
          expect(Resource.all.count).to eql(1)
        end
      end
    end

    context 'while not signed in' do
      before :each do
        controller.stub(:current_user).and_return(nil)
      end

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
      @name = 'another resource name'
      @update_params = {
                          resource: {
                            name: @name,
                            link: 'resource_link',
                            description: 'description',
                            full_description: 'resource_full_description',
                            source: 'A cool person',
                            tag_list: 'resource_tag_list'
                          },
                          image: 'image.jpg'
                      }
    end

    context 'as an admin user' do
      context 'with a resource owned by the admin' do
        before :each do
          controller.stub(:current_user).and_return(@admin_user)
          @step = FactoryGirl.create(:step)
          @resource = FactoryGirl.create(:resource, user: @user, step_id: @step.id)
          @update_params[:id] = @resource.id
          @update_params[:resource][:step_id] = @step.id
          @update_params[:user_id] = @user.id
       end

        it 'should update any resource' do
          patch :update, @update_params
          @resource.reload
          expect(@resource.name).to eql(@name)
        end

        it 'should redirect to the edit step page' do
          patch :update, @update_params
          response.should redirect_to(edit_step_path(@step))
        end

        context 'resource without a step' do
          it 'redirects to the resources index page' do
            @update_params[:resource][:step_id] = nil
            patch :update, @update_params
            response.should redirect_to(resources_path)
          end
        end
      end

      context 'with a resource owned by another user' do
        before :each do
          controller.stub(:current_user).and_return(@admin_user)
          @step = FactoryGirl.create(:step)
          @resource = FactoryGirl.create(:resource, user: @user, step_id: @step.id)
          @update_params[:id] = @resource.id
          @update_params[:resource][:step_id] = @step.id
          @update_params[:user_id] = @user.id
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
        controller.stub(:current_user).and_return(@user)
        @step = FactoryGirl.create(:step)
        @resource = FactoryGirl.create(:resource, user: @user, step_id: @step.id)
        @update_params[:id] = @resource.id
        @update_params[:resource][:step_id] = @step.id
        @update_params[:user_id] = @user.id

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
            @update_params[:id] = other_users_resource.id
            @update_params[:user_id] = other_user.id
            patch :update, update_params
            expect(other_users_resource.name).to eql('resource_name')
          end
        end
      end
    end

    context 'while not signed in' do
      before :each do
        @resource = FactoryGirl.create(:resource, user: @admin_user)
        @update_params[:id] = @resource.id
        @update_params[:user_id] = @user.id
        controller.stub(:current_user).and_return(nil)
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
        controller.stub(:current_user).and_return(@admin_user)
        get :index, @get_params
        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resources_path)
        assert_not_nil assigns(:resources)
      end

    end

    context 'as a user' do
      it 'should show the list of resources' do
        controller.stub(:current_user).and_return(@user)
        get :index, @get_params
        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resources_path)
      end
    end

    context 'while not signed in' do
      before :each do
        controller.stub(:current_user).and_return(nil)
      end

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
      it 'assigns a new resource to @resource' do
        controller.stub(:current_user).and_return(@admin_user)
        step = FactoryGirl.create(:step, id: 0)

        get :new, {:step_id => step.id}

        assigns(:resource).should be_a_new(Resource)
        assigns(:resource).step_id.should eql(step.id)
        response.should render_template(:new)
      end
    end

    context 'as a user' do
      it 'should view the create-a-resource page' do
        controller.stub(:current_user).and_return(@user)

        get :new, {:step_id => 0}

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_resource_path)
      end
    end

    context 'while not signed in' do
      before :each do
        controller.stub(:current_user).and_return(nil)
      end

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
        controller.stub(:current_user).and_return(@admin_user)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resource_path)
      end
    end

    context 'as a user' do
      it 'should show the requested resource' do
        controller.stub(:current_user).and_return(@user)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resource_path)
      end
    end

    context 'while not signed in' do
      before :each do
        controller.stub(:current_user).and_return(nil)
      end

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

  describe "GET filter" do
    before :each do
      controller.stub(:current_user).and_return(@admin_user)
    end

    context "a filter query exists" do
      it 'returns resources with the given filter' do
        mock_resources = [double(:resource)]
        Resource.should_receive(:where).and_return(mock_resources)

        post :filter, {resource_search: "something" }

        assigns(:resources).should =~( mock_resources)
        response.should render_template("index")
      end
    end
  end

  describe "POST sort" do
    before :each do
      controller.stub(:current_user).and_return(@admin_user)
    end

    it 'should make call to sort on sorter' do
      ResourcesSorter.any_instance.should_receive(:sort).and_return(nil)
      post :sort, {resource: [3 , 4 , 5]}
    end
  end

  describe 'GET reorder' do
    before :each do
      @mock_step = double(:step)
      Step.stub(:find).and_return(@mock_step)
      @mock_resources = [double(:resource)]
      @mock_step.stub(:resources).and_return(@mock_resources)
      controller.stub(:current_user).and_return(@admin_user)
    end

    it "assigns the step id as @step_id" do
      @mock_resources.stub(:order)
      get :reorder, {step_id: 0}
      assigns(:step_id).should == "0"
    end

    it 'should assign resources ordered by position' do
      @mock_resources.should_receive(:order).with(:position).and_return(@mock_resources)

      get :reorder, {step_id: 0}

      assigns(:resources).should eql @mock_resources
    end
  end
end
