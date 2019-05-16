class RelationshipsController < ApplicationController



  before_action :logged_in_user




  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # redirect_to user

    # ajax, replaces redirect_to user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end

  end

  def destroy
    # we get the relationship in the request,
    # thus can access *its* id,
    # and retrieve either followed or follower
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    # redirect_to user

    # ajax, replaces redirect_to user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end


  end



end
