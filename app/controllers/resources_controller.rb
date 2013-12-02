class ResourcesController < ApplicationController
  before_filter :redirect_if_not_signed_in

  before_filter :redirect_if_unauthorized, except: [:create, :destroy, :edit, :index, :new, :show, :update]

  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_resource_associations, only: [:index, :show, :new, :edit, :create, :update]

  def index
    if params[:tag].present?
      @resources = Tag.find(params[:tag]).resources.order("name").page(params[:page])
    else
      @resources = Resource.order("name").page(params[:page])
    end
  end

  def show
    @bookmark = Bookmark.new
    @bookmark.user_id = current_user.id
    @bookmark.resource_id = @resource.id
    @comments = Comment.where(resource_id: @resource.id)
  end

  def new
    @resource = Resource.new()
  end

  def edit
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.user = current_user || User.find(params[:user_id])

    ActiveRecord::Base.transaction do
      @resource_saved = @resource.save
      update_color_associations
      #update_phase_associations
    end

     if @resource_saved
       respond_to do |format|
        format.html { redirect_to resources_path, notice: 'Resource was successfully created.' }
        format.json { render action: 'show', status: :created, location: resource_path }
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.present? and current_user.can_edit_and_delete_resource? current_user, @resource
      ActiveRecord::Base.transaction do
        @resource_saved = @resource.update(resource_params)

        @resource.color_associations = []
        update_color_associations

        #@resource.phase_associations = []
        #update_phase_associations
      end

      if @resource_saved
        respond_to do |format|
          format.html { redirect_to @resource, notice: 'Resource was successfully updated.' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { render action: 'edit' }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end

    else
      redirect_to root_path, notice: "Not authorized to edit this resource!" and return
    end
  end

  def destroy
    if current_user.present? and current_user.can_edit_and_delete_resource? current_user, @resource

      @resource.destroy

      redirect_path = request.path.include?('resource') ? resources_url : user_path(current_user.id)

      respond_to do |format|
        format.html { redirect_to redirect_path }
        format.json { head :no_content }
      end

    else
      redirect_to root_path, notice: "Not authorized to destroy this resource!"
    end
  end

  private
  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:name, :link, :description, :full_description, :source, :tag_list, color_ids: [], phase_ids: [], format_ids: [])
  end

  def set_resource_associations
    @colors = Color.all
    @industries = Industry.all
    #@phases = Phase.all
  end

  def update_color_associations
    params[:color_ids].reject(&:empty?).each do |color_id|
      @resource.color_associations << ColorAssociation.create(color_id: color_id)
    end
  end

  #def update_phase_associations
  #  params[:phase_ids].reject(&:empty?).each do |phase_id|
  #    @resource.phase_associations << PhaseAssociation.create(phase_id: phase_id)
  #  end
  end
