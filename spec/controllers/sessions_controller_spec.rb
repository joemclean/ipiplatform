require 'spec_helper'

describe SessionsController do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe '#create' do
    before :each do
      @user_params = { email: @user.email, password: @user.password }
      User.any_instance.stub(:authenticate).and_return(true)
    end

    context 'as the first site interaction' do
      it 'should redirect the user to the homepage' do
        get :new

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_session_path)

        get :create, @user_params

        expect(response.status).to be(302)
        response.should redirect_to(root_path)
      end
    end

    context 'after viewing homepage' do
      it 'should redirect the user to the homepage' do
        session[:previous_url] = '/'

        get :new

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_session_path)

        get :create, @user_params

        expect(response.status).to be(302)
        response.should redirect_to(root_path)
      end
    end

    context 'after trying to view resources' do
      it 'should redirect the user to the resources page' do
        session[:previous_url] = '/resources/'

        get :new

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_session_path)

        get :create, @user_params

        expect(response.status).to be(302)
        response.should redirect_to(resources_path + '/')
      end
    end
  end
end