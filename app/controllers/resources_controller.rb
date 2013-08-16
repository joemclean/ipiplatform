class ResourcesController < ApplicationController
  before_filter :signed_in?
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_resource_associations, only: [:index, :show, :new, :edit]

  def index
    @filter_params = {plan: false, act: false, observe: false, reflect: false}
  end

  def show
    @bookmark = Bookmark.new
    @bookmark.user_id = current_user.id
    @bookmark.resource_id = @resource.id
  end

  def new
    @resource = Resource.new()
  end

  def edit
  end

  def create
    session[:resource_params].deep_merge!(params[:resource]) if params[:resource]
    @resource = Resource.new(resource_params)
    @resource.user_id = session[:user_id]
    if @resource.save
      redirect_to @resource, notice: 'Resource was successfully created'
    else
      render "new"
    end
         
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end

  private
    def set_resource
      @resource = Resource.find(params[:id])
    end

    def resource_params
      params.require(:resource).permit(:name, :link, :description, :full_description, trait_ids: [], industry_ids: [], phase_ids: [])
    end

    def set_resource_associations
      @traits = Trait.all
      @industries = Industry.all
      @resources = Resource.all
      @phases = Phase.all
    end
end
