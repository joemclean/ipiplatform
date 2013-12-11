require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    controller.stub(:current_user).and_return(@user)
  end

  describe '#show' do
    context 'when a user views their profile' do
      before :each do
        @user_params = { id: @user.id.to_param }
        session[:user_id] = @user.id

        Resource.any_instance.stub_chain(:where, :last)
        Bookmark.any_instance.stub_chain(:where, :last)
      end

      it 'should show the user\'s profile' do
        get :show, @user_params

        expect(controller.request.path).to eql(user_path)
        expect(response.status).to be(200)
      end
    end

    context 'when a user tries to view another user\'s profile' do
      before :each do
        other_user = FactoryGirl.create(:user)
        @other_user_params = { id: other_user.id.to_param }
      end

      it 'should redirect the user' do
        get :show, @other_user_params

        expect(response.status).to be(302)
        response.should redirect_to(root_path)
      end

      it 'should receive an error' do
        get :show, @other_user_params

        expect(flash[:notice]).to eq("You are not authorized to view that page.")
      end
    end
  end
end