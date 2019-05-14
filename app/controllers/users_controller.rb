class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    # using pagination will_paginate etc
    @users = User.paginate(page: params[:page])
  end


  def show
    # we create this instance var to be used by the 'show' view
    @user = User.find(params[:id])
    # debugger
  end




  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # new user saved - Handle a successful save
      log_in @user
      # assign a msg to rails flash msg hash
      flash[:success] = "Hello newly created user, Welcome to the Sample App!"
      # redirect to the new user's profile
      redirect_to @user  # same as: redirect_to user_url(@user)
    else
      render 'new'
    end
  end


  # =======================================


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  # =======================================



  private
  # returns a filtered version of params
  # require -- raises error if a :user attr missing
  # permit -- ret only the specified attrs
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


  # Before filters
  # =======================================

  # Confirms and alerts logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end


  # Confirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


end
