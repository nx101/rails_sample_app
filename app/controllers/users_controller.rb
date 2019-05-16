class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update,
                                        :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    # using pagination will_paginate etc
    @users = User.where(activated: true).paginate(page: params[:page])
  end


  def show
    # we create this instance var to be used by the 'show' view
    @user = User.find(params[:id])
    # expose @microposts to page pagination in view, of class ActiveRecord::Relation
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
    # debugger
  end




  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      # new user saved - Handle a successful save

      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url

      # log_in @user
      # # assign a msg to rails flash msg hash
      # flash[:success] = "Hello newly created user, Welcome to the Sample App!"
      # # redirect to the new user's profile
      # redirect_to @user  # same as: redirect_to user_url(@user)
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


  def following
    @title = "Users I'm Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "My Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
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
