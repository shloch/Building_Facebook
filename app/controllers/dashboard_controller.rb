class DashboardController < ApplicationController
    

    
    def home
        user = current_user
        
        if user.nil?       
            redirect_to controller: 'staticpages', action: 'home'
        else
            redirect_to controller: 'dashboard', action: 'home_page', uuid: user.id.to_s+'356a19'
        end
    end

    def home_page
        @user_id = params[:uuid].first
        @post = Post.new 
        @post_comment = PostComment.new
        #@you_and_friends_posts = Post.all.includes(:author).includes(:post_comments => :user).includes(:like_posts).order(id: :desc)

      
        friends_IDs_array = Friendship.where(inviting_id:@logged_user).where(status:'accepted').pluck(:invited_id)
        friends_IDs_array << @logged_user.id
        @you_and_friends_posts = Post.includes(:author).includes(:post_comments => :user).includes(:like_posts).order(id: :desc).where(author: friends_IDs_array).limit(25)

    end

    
end