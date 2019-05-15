require 'test_helper'

class MicropostTest < ActiveSupport::TestCase


  def setup
    @user = users(:michael)

    # (As with new, build returns an object in memory
    # but doesn’t modify the database.)
    # Once we define the proper associations,
    # the resulting @micropost variable will automatically
    # have a user_id attribute equal to its associated user’s id.
    @micropost = @user.microposts.build(content: "Lorem ipsum")

    # !! The code below is NOT idiomatically correct,
    # due to the has_many assoc. microposts need to be
    # created from the User thus having a user_id.
    # @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
  end





  test "should be valid" do
    assert @micropost.valid?
  end


  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end


  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end



  # Ordering and scope

  test "order should be most recent first" do
    assert_equal microposts(:most_recent), Micropost.first
  end




end
