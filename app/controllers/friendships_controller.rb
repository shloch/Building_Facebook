class FriendshipsController < ApplicationController
    
    layout 'frienship_template'
   
    def index
        @users = User.all.where.not(id:@logged_user.id).includes(:inviting_friends).includes(:invited_friends)
    end

    def add_friend
        friend = User.find(params[:id].to_i)
        current_user.sent_invites.create(invited_friend:friend)
        flash[:info] = "Friend request sent successfully"  
        redirect_to friendships_path
    end

    def your_friends
        @friends = Friendship.where(inviting_id:@logged_user).includes(:invited_friend).where(status:'accepted')
    end

    def pending_requests
        @requests_sent = Friendship.where(inviting_id:@logged_user).includes(:invited_friend).where(status:'pending')
        @requests_received = Friendship.where(invited_id:@logged_user).includes(:inviting_friend).where(status:'pending')
    end

    def accept_request
        @friendship = Friendship.find(params[:friendshipid])
        @friendship.status = 'accepted'
        @friendship.save
        #file new query
        Friendship.create(inviting_id:@friendship.invited_id, invited_id:@friendship.inviting_id, status:'accepted')
        flash[:info] = "CONGRATS !!.....You have new friend #{@friendship.invited_friend.name}"  
        redirect_to your_friends_friendships_path

    end

    def destroy
        friend_id = params[:id]
        #p "friend id -------> #{friend_id}"
        #p "looged user---->  #{@logged_user.id}"
        Friendship.find_by(inviting_id:@logged_user, invited_id: friend_id).delete 
        Friendship.find_by(inviting_id:friend_id, invited_id: @logged_user).delete
        flash[:info] = "Frienship deleted successfully"  
        redirect_to your_friends_friendships_path
    end

    def turn_down
        Friendship.delete(params[:id])
        flash[:info] = "Frienship request is turned down" 
        redirect_to pending_requests_friendships_path
    end

    

    
end
