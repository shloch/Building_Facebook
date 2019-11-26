class ProfilesController < ApplicationController
  layout 'profile_page'
  def show
    @user_id = params[:id]
    @profile_user = User.find(@user_id)
    # @friendships = @profile_user.invited_friends.where(status:"accepted")
    @friendships = Friendship.get_friends_of_user(@profile_user)
    @post = Post.new
    @post_comment = PostComment.new
    @user_posts = Post.all.includes(:author).includes(post_comments: :user).includes(:like_posts).where(author: @user_id).order(id: :desc).limit(20)
  end
end
