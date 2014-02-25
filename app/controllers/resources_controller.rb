class ResourcesController < ApplicationController
  before_action :redirect_if_not_signed_in

  before_action :redirect_if_unauthorized, except: [:create, :destroy, :edit, :index, :new, :show, :update, :reorder, :sort, :filter]

  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_resource_associations, only: [:index, :show, :new, :edit, :create, :update, :filter]

  def index
    if params[:tag].present?
      @resources = Tag.find(params[:tag]).resources.order("name").page(params[:page])
    else
      @resources = Resource.order("name").page(params[:page])
    end
  end

  def filter
    resource_search = params[:resource_search].downcase

    if resource_search.present?
      @resources = Resource.where("name LIKE ? OR description LIKE ? OR full_description LIKE ? OR source LIKE ? OR tag_list LIKE ?", "%" + resource_search + "%", "%" + resource_search + "%", "%" + resource_search + "%", "%" + resource_search + "%","%" + resource_search + "%")

      @resources = Kaminari.paginate_array(@resources).page(params[:page])
    else
      @resources = Resource.order("name").page(params[:page])
    end
    render :index
  end

  def show
    @bookmark = Bookmark.new
    @bookmark.user_id = current_user.id
    @bookmark.resource_id = @resource.id
    @comments = Comment.where(resource_id: @resource.id)
  end

  def new
    @resource = Resource.new(step_id: params[:step_id])
  end

  def edit
  end

  def create
    @resource = Resource.new(resource_params)
    @resource.user = current_user

    if @resource.save
      if @resource.step.nil?
        redirect_to resources_path, notice: 'Resource was successfully created.'
      else
        redirect_to edit_step_path(@resource.step), notice: 'Resource was successfully created.'
      end
    else
      render action: 'new'
    end
  end

  def update
    if current_user.present? and current_user.can_edit_and_delete_resource? current_user, @resource
      if @resource.update(resource_params)
        path = @resource.step.nil? ? resources_path : edit_step_path(@resource.step.id)
        redirect_to path, notice: 'Resource was successfully updated.'
      else
        render action: 'edit'
      end
    else
      redirect_to root_path, notice: "Not authorized to edit this resource!" and return
    end
  end

  def destroy
    if current_user.present? and current_user.can_edit_and_delete_resource? current_user, @resource
      @resource.destroy
      redirect_to request.referrer
    else
      redirect_to root_path, notice: "Not authorized to destroy this resource!"
    end
  end

  def sort
    ResourcesSorter.new.sort(params[:resource])
    render nothing: true
  end

  def reorder
    @resources = Step.find(params[:step_id]).resources.order(:position)
    @step_id = params[:step_id]
  end

  def existing
  end

  def add_to_step
  end

  private
  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:name, :link, :description, :full_description, :source, :tag_list, :image, :file, :step_id, value_proposition_ids: [], format_ids: [])
  end

  def set_resource_associations
    @value_proposition = ValueProposition.all
  end

end
