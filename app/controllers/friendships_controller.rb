class FriendshipsController < ApplicationController
   
    def index
        @post = Post.new
        @users = User.all
    end

    def add_friend
        friend = User.find(params[:id].to_i)
        current_user.sent_invites.create(invited_friend:friend)
        render plain: 'plain text'
    end
end
