class FriendshipsController < ApplicationController
    
    layout 'frienship_template'
   
    def index
        @users = User.users_except_me_with_their_friends(@logged_user)
    end

    def add_friend
        friend = User.find(params[:id].to_i)
        if (friend != @logged_user)
            current_user.sent_invites.create(invited_friend:friend)
            flash[:info] = "Friend request sent successfully"  
        else 
            flash[:warning] = "You can't sent friendship to yourself" 
        end
        redirect_to friendships_path
    end

    def your_friends
        @friends = Friendship.get_friends_of_user(@logged_user)
    end

    def pending_requests
        @requests_sent = Friendship.get_friend_requests(@logged_user)
        #@requests_received = Friendship.where(invited_id:@logged_user).includes(:inviting_friend).where(status:'pending')
    end

    def accept_request
        @friendship = Friendship.find(params[:friendshipid])
        friendID = params[:friendID]
        if (@friendship.invited_id == @logged_user && @friendship.inviting_id == friendID) #only accept if request was sent to u
            @friendship.status = 'accepted'
            @friendship.save
        
            #file new query
            Friendship.create(inviting_id:@friendship.invited_id, invited_id:@friendship.inviting_id, status:'accepted')
            flash[:info] = "CONGRATS !!.....You have new friend #{@friendship.invited_friend.name}" 
        else 
            flash[:warning] = "WARNING !!....YOU CANNOT ACCEPT REQUEST NOT SENT TO YOU" 
        end
         
        redirect_to your_friends_friendships_path

    end

    def destroy
        friend_id = params[:id]
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
