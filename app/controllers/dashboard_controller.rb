class DashboardController < ApplicationController
   

    
    def home
        if !user_signed_in?
            redirect_to "/staticpages/home"
        
        else
            @post = Post.new 
            @you_and_friends_posts = Post.all.order(id: :desc)
        end
    end
end