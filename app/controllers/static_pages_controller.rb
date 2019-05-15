class StaticPagesController < ApplicationController



  def home
    if logged_in?
      # new empty for micropost form
      @micropost  = current_user.microposts.build
      # ordered pagination of user's microposts
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end



  def help
  end




  def about
  end



  def contact
  end



end


