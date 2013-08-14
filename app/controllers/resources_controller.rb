class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in?

  def index
    @resources = Resource.all
  end

  def show
    @bookmark = Bookmark.new
    @bookmark.user_id = current_user.id
    @bookmark.resource_id = @resource.id
  end

  def new
    session[:resource_params] ||= {}
    @resource = Resource.new(session[:resource_params])
    @resource.current_step = session[:resource_step]
    @traits = Trait.all
    @industries = Industry.all
  end

  def edit
    @traits = Trait.all
  end

  # POST /resources
  # POST /resources.json
  def create
    session[:resource_params].deep_merge!(params[:resource]) if params[:resource]
    @resource = Resource.new(session[:resource_params])
    @resource.current_step = session[:resource_step]
    @traits = Trait.all
    @industries = Industry.all
    @resource.user_id = session[:user_id]
    if @resource.valid?
      if params[:back_button]
        @resource.previous_step
      elsif @resource.last_step?
        @resource.save if @resource.all_valid?
      else
        @resource.next_step
      end
    session[:resource_step] =  @resource.current_step
    end
    if @resource.new_record?
      render "new"
    else
      session[:resource_step] = session[:resource_params] = nil
      flash[:notice] = "resource saved"
      redirect_to @resource
    end
         
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
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

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url }
      format.json { head :no_content }
    end
  end
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:name, :link, :description, :full_description, trait_ids: [], industry_ids: [])
    end
end
