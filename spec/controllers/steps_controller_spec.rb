require 'spec_helper'

describe StepsController do

 let(:valid_attributes) { { "name" => "MyString" } }

 let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all steps as @steps" do
      step = Step.create! valid_attributes
      get :index, {}, valid_session
      assigns(:steps).should eq([step])
    end
  end

  describe "GET show" do
    it "assigns the requested step as @step" do
      step = Step.create! valid_attributes
      get :show, {:id => step.to_param}, valid_session
      assigns(:step).should eq(step)
    end
  end

  describe "GET new" do
    it "assigns a new step as @step" do
      get :new, {}, valid_session
      assigns(:step).should be_a_new(Step)
    end
  end

  describe "GET edit" do
    it "assigns the requested step as @step" do
      step = Step.create! valid_attributes
      get :edit, {:id => step.to_param}, valid_session
      assigns(:step).should eq(step)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Step" do
        expect {
          post :create, {:step => valid_attributes}, valid_session
        }.to change(Step, :count).by(1)
      end

      it "assigns a newly created step as @step" do
        post :create, {:step => valid_attributes}, valid_session
        assigns(:step).should be_a(Step)
        assigns(:step).should be_persisted
      end

      it "redirects to the created step" do
        post :create, {:step => valid_attributes}, valid_session
        response.should redirect_to(Step.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved step as @step" do
        # Trigger the behavior that occurs when invalid params are submitted
        Step.any_instance.stub(:save).and_return(false)
        post :create, {:step => { "name" => "invalid value" }}, valid_session
        assigns(:step).should be_a_new(Step)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Step.any_instance.stub(:save).and_return(false)
        post :create, {:step => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested step" do
        step = Step.create! valid_attributes
        # Assuming there are no other steps in the database, this
        # specifies that the Step created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Step.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => step.to_param, :step => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested step as @step" do
        step = Step.create! valid_attributes
        put :update, {:id => step.to_param, :step => valid_attributes}, valid_session
        assigns(:step).should eq(step)
      end

      it "redirects to the step" do
        step = Step.create! valid_attributes
        put :update, {:id => step.to_param, :step => valid_attributes}, valid_session
        response.should redirect_to(step)
      end
    end

    describe "with invalid params" do
      it "assigns the step as @step" do
        step = Step.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Step.any_instance.stub(:save).and_return(false)
        put :update, {:id => step.to_param, :step => { "name" => "invalid value" }}, valid_session
        assigns(:step).should eq(step)
      end

      it "re-renders the 'edit' template" do
        step = Step.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Step.any_instance.stub(:save).and_return(false)
        put :update, {:id => step.to_param, :step => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested step" do
      step = Step.create! valid_attributes
      expect {
        delete :destroy, {:id => step.to_param}, valid_session
      }.to change(Step, :count).by(-1)
    end

    it "redirects to the steps list" do
      step = Step.create! valid_attributes
      delete :destroy, {:id => step.to_param}, valid_session
      response.should redirect_to(steps_url)
    end
  end

end
