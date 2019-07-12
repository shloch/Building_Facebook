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
        @you_and_friends_posts = Post.all.includes(:author).includes(:post_comments => :user).includes(:like_posts).order(id: :desc)

       # @you_and_friends_posts = Post.all.includes(:author).includes(:post_comments => :user).includes(:like_posts).order(id: :desc)
       # @you_and_friends_posts = @logged_user.includes(:post, :invited_friends => :post).where(status:'accepted')
        #@you_and_friends_posts = Post.all.includes(:author=> sent_invites).where(projects: {id: project_id})
    end

    
end