class UsersController < ApplicationController

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
      # assign a msg to rails flash msg hash
      flash[:success] = "Hello newly created user, Welcome to the Sample App!"
      # redirect to the new user's profile
      redirect_to @user  # same as: redirect_to user_url(@user)
    else
      render 'new'
    end
  end


  private
  # returns a filtered version of params
  # require -- raises error if a :user attr missing
  # permit -- ret only the specified attrs
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

end
