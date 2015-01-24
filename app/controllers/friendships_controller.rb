class FriendshipsController < ApplicationController

	before_filter :setup_friends

	def accept
		if @user.requested_friends.include?(@friend)
			Friendship.accept(@user, @friend)
			flash[:notice] = "Friendship Accepted"
		else
			flash[:notice] = "No Friendship Request"
		end
	end

	def decline
		if @user.requested_friends.include?(@friend)
			Friendship.breakup(@user, @friend)
			flash[:notice] = "Friendship Rejected"
		else
			flash[:notice] = "No Friendship Request"
		end
	end

	def cancel 
		if @user.pending_friends.include?(@friend)
      		Friendship.breakup(@user, @friend)
      		flash[:notice] = "Friendship Canceled"
    	else
      		flash[:notice] = "No Friendship request"
    	end
  	end

	def delete
	    if @user.friends.include?(@friend)
	      Friendship.breakup(@user, @friend)
	      flash[:notice] = "Friendship Deleted"
	    else
	      flash[:notice] = "No Friendship request"
	    end
	    
	end

	def index
		@users = User.all
	end

	def destroy 
		if @user.friends.include?(@friend)
			delete
		else
			if @user.requested_friends.include?(@friend)
				decline
			else 
				if @user.pending_friends.include?(@friend)
					cancel
				end
			end
		end
		respond_to do |format|
			format.js
		end
	end

	def update
		accept
		respond_to do |format|
			format.js
		end
	end

	def create
		Friendship.request(@user, @friend)
		respond_to do |format|
			format.js
		end
	end

	private

		def setup_friends
			@user = current_user
			@friend = User.find_by_id(params[:friendship][:friend_id])
		end
		
end
