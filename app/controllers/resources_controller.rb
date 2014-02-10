class ResourcesController < ApplicationController
  before_filter :redirect_if_not_signed_in

  before_filter :redirect_if_unauthorized, except: [:create, :destroy, :edit, :index, :new, :show, :update, :filter]

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
    if params[:value_proposition].present?
      @resources = Resource.all.includes(:value_propositions).where("value_propositions.name LIKE ?", "%"+params[:value_proposition]+"%").references(:value_propositions).each {|resource| resource.reload}

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
    @resource.user = current_user || User.find(params[:user_id])


    ActiveRecord::Base.transaction do
      @resource_saved = @resource.save
      update_value_proposition_associations
    end

     if @resource_saved
       respond_to do |format|
        format.html { redirect_to resource_path(@resource), notice: 'Resource was successfully created.' }
        format.json { render action: 'show', status: :created, location: resource_path }
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @value_proposition.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.present? and current_user.can_edit_and_delete_resource? current_user, @resource
      ActiveRecord::Base.transaction do
        @resource_saved = @resource.update(resource_params)

        @resource.value_proposition_associations = []
        update_value_proposition_associations

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
    params.require(:resource).permit(:name, :link, :description, :full_description, :source, :tag_list, :image, :file, :step_id, value_proposition_ids: [], format_ids: [])
  end

  def set_resource_associations
    @value_proposition = ValueProposition.all
  end

  def update_value_proposition_associations
    params[:value_proposition_ids].reject(&:empty?).each do |value_proposition_id|
      @resource.value_proposition_associations << ValuePropositionAssociation.create(value_proposition_id: value_proposition_id)
    end
  end

  end
