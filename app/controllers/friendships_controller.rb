class FriendshipsController < ApplicationController
    before_action :get_logged_in_user
    layout 'frienship_template'
   
    def index
        @users = User.all.where.not(id:@logged_user.id).includes(:inviting_friends).includes(:invited_friends)
    end

    def add_friend
        friend = User.find(params[:id].to_i)
        current_user.sent_invites.create(invited_friend:friend)
        flash[:warning] = "Friend request sent successfully"  
        redirect_to friendships_path
    end

    def your_friends
        @friends = Friendship.where(inviting_id:@logged_user).includes(:invited_friend).where(status:'accepted')
    end

    def pending_requests
        @requests_sent = Friendship.where(inviting_id:@logged_user).includes(:invited_friend).where(status:'pending')
        @requests_received = Friendship.where(invited_id:@logged_user).includes(:inviting_friend).where(status:'pending')
    end

    private

    def get_logged_in_user
        @logged_user = current_user
    end
end
