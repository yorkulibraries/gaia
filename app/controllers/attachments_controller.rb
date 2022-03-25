class AttachmentsController < ApplicationController
  before_action :login_required
  authorize_resource

  before_action do
    @data_request = DataRequest.find(params[:data_request_id])
  end

  def index
    @attachments = @data_request.attachments.all

  end

  def show
    @attachment = @data_request.attachments.find(params[:id])
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = @data_request.attachments.new(attachment_params)
    @attachment.created_by_id = current_user.id

    if @attachment.save

      respond_to do |format|
        format.html { redirect_to @data_request, :notice => "Successfully created attachment." }
        format.js do
        end
      end

    else

      respond_to do |format|
        format.html { render :action => 'new' }
        format.js do
        end
      end

    end # else end
  end

  def edit
    @attachment = Attachment.find(params[:id])
  end

  def update
    @attachment = Attachment.find(params[:id])
    if @attachment.update_attributes(attachment_params)
      redirect_to @data_request, :notice  => "Successfully updated attachment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])

    if @data_request.status != DataRequest::FILLED
      @attachment.destroy
      redirect_to @data_request, :notice => "Successfully destroyed attachment."
    else
      redirect_to @data_request, :alert => "Cannot Delete Attachment for filled requests"
    end

  end

  private
  def attachment_params
    params.require(:attachment).permit(:name, :description, :file)
  end


end
