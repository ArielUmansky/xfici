class FriendshipsController < ApplicationController

	before_filter :setup_friends

	def accept
		if current_user.requested_friends.include?(@friend)
			Friendship.accept(current_user, @friend)
			flash[:notice] = "Friendship Accepted"
		else
			flash[:notice] = "No Friendship Request"
		end
	end

	def decline
		if current_user.requested_friends.include?(@friend)
			Friendship.breakup(current_user, @friend)
			flash[:notice] = "Friendship Rejected"
		else
			flash[:notice] = "No Friendship Request"
		end
	end

	def cancel 
		if current_user.pending_friends.include?(@friend)
      		Friendship.breakup(current_user, @friend)
      		flash[:notice] = "Friendship Canceled"
    	else
      		flash[:notice] = "No Friendship request"
    	end
  	end

	def delete
	    if current_user.friends.include?(@friend)
	      Friendship.breakup(current_user, @friend)
	      flash[:notice] = "Friendship Deleted"
	    else
	      flash[:notice] = "No Friendship request"
	    end
	    
	end

	def index
		@users = User.all
	end

	def destroy 
		if current_user.friends.include?(@friend)
			delete
		else
			if current_user.requested_friends.include?(@friend)
				decline
			else 
				if current_user.pending_friends.include?(@friend)
					cancel
				end
			end
		end
		respond_to do |format|
			format.html { redirect_to @friend }
			format.js
		end
	end

	def update
		accept
		respond_to do |format|
			format.html { redirect_to @friend }
			format.js
		end
	end

	def create
		Friendship.request(current_user, @friend)
		respond_to do |format|
			format.html { redirect_to @friend }
			format.js
		end
	end

	private

		def setup_friends
			@friend = User.find_by_id(params[:friendship][:friend_id])
		end
		
end
