class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorized_admin, :only => [:index]
  before_filter :authorized_user, :only => [:show]

  # GET /users
  def index
  	@users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/edit
  def edit
    @user = current_user
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  # Only admin can view all users.
  def authorized_admin
    unless current_user.try(:admin?)
      redirect_to(current_user, :notice => 'That page is protected.')
    end
  end

  # Prevent users from viewing/modifying other users if id is known.
  def authorized_user
    if current_user.try(:admin?) #if admin they are allowed to modify any user's data
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    redirect_to root_path if @user.nil?
  end


end
