class SessionsController < ApplicationController
  def new
  end

  def create
    # using user since @user isn't an est instance var in a sessions controller
    user = User.find_by(email: params[:session][:email].downcase)
    # check user found && auth by provided password
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
