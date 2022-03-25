class UsersController < ApplicationController
  before_action :login_required
  authorize_resource

  def index
    @users_grouped = User.alphabetical.group_by  { |user| user.role }
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.username = @user.name.parameterize if @user.username.blank? && !@user.name.blank?
    @user.usertype = "UNDERGRAD" if @user.usertype.blank?

    if @user.save
      redirect_to @user, :notice => "Successfully created user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.deleted = true
    @user.save
    redirect_to users_url, :notice => "Successfully destroyed user."
  end


  ### ADDITIONAL ACTIONS ###

  def requests
    @data_requests = current_user.data_requests.open_or_filled.order("status desc")
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :role)
  end


end
