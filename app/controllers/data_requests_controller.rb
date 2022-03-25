class DataRequestsController < ApplicationController
  authorize_resource
  before_action :login_required

  def index

    case params[:status]
    when DataRequest::OPEN
      @data_requests = DataRequest.opened.order("requested_date desc")
    when DataRequest::FILLED
      @data_requests = DataRequest.filled.order("completed_date desc, expires_after desc")
    when DataRequest::CANCELLED
      @data_requests = DataRequest.cancelled.order("requested_date desc")
    when DataRequest::EXPIRED
      @data_requests = DataRequest.expired.order("expires_after desc")
    else
      @data_requests = DataRequest.opened.order("requested_date desc")
    end

  end

  def show
    @data_request = DataRequest.find(params[:id])
    @attachments = @data_request.attachments.all
    @attachment = Attachment.new
  end

  def new
    @data_request = DataRequest.new
  end

  def create
    @data_request = DataRequest.new(data_request_params)
    @data_request.status = DataRequest::OPEN
    @data_request.expires_after = 2.months.from_now.strftime("%Y-%m-%d")
    @data_request.requested_by_id = current_user.id
    @data_request.requested_date = Date.today.to_date
    # Reset the params names if count is 1 in post
    @data_request.participants_names = "" if @data_request.participants_count == 1

    if @data_request.save
      # Add Terms of Agreement for data request created.
      terms_path = Rails.root + 'public/Conditions_of_use_agreement.docx'
      @attachment = @data_request.attachments.new
      @attachment.file = File.open(terms_path)
      @attachment.name = "Conditions_Of_Use"
      @attachment.save

      DataRequestMailer.new_request_confirmation(@data_request.requested_by, @data_request).deliver_later
      DataRequestMailer.new_request_notification(@data_request).deliver_later
      redirect_to @data_request, notice: "Successfully created data request."
    else
      render :action => 'new'
    end
  end

  def edit
    @data_request = DataRequest.find(params[:id])
  end

  def update
    # Reset the params names if count is 1 in post
    params[:data_request][:participants_names] = "" if params[:data_request][:participants_count] == "1"

    @data_request = DataRequest.find(params[:id])
    if @data_request.update_attributes(data_request_params)
      redirect_to @data_request, notice: "Successfully updated data request."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @data_request = DataRequest.find(params[:id])
    @data_request.destroy
    redirect_to data_requests_url, notice: "Successfully destroyed data request."
  end

  ## EXTRA ACTIONS ##

  def fill
    @data_request = DataRequest.find(params[:id])
    @data_request.fill(params[:data_request][:expires_after], current_user)
    DataRequestMailer.filled_request_notification(@data_request.requested_by, @data_request).deliver_later
    redirect_to @data_request, notice: "The request was filled by #{current_user.name}"
  end

  def cancel
  ## Cancelled requests are NOT deleted but attachments associated with them are. ##

    @data_request = DataRequest.find(params[:id])
    @data_request.status = DataRequest::CANCELLED

    if @data_request.save

      for attachment in @data_request.attachments.all
        attachment.destroy
      end

      if @data_request.attachments.count == 0

        DataRequestMailer.cancel_confirmation(@data_request.requested_by, @data_request).deliver_later

        redirect_to @data_request, notice: "The request was cancelled, all files removed."
      else
        redirect_to @data_request, error: "The request was cancelled, but could not delete the files!"
      end
    else
      redirect_to @data_request, error: "Could not cancel request. Attachments were not deleted / error."
    end
  end

  private
  def data_request_params
    params.require(:data_request).permit(:course, :course_info, :project_description, :supervisor, :phone, :alt_email, :project_due_date, :datasets, :scanned_maps, :other_info, :participants_count, :participants_names, :cancellation_reason, :expires_after, :completed_date, :status)
  end

end
