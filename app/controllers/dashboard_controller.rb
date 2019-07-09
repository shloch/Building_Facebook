class DashboardController < ApplicationController
   

    
    def home
        if !user_signed_in?
            redirect_to "/staticpages/home"
        
        else
            @post = Post.new 
            @you_and_friends_posts = Post.all.includes(:author).includes(:post_comments).order(id: :desc)

            #User.includes(:addresses => {{:phones => :service}, {:code => :code_type}}, :orders)
            #@you_and_friends_posts = Post.joins(‘LEFT JOIN posts ON posts.author_id = users.id’).order(id: :desc)
        end
    end
end