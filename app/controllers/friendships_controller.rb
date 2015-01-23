class FriendshipsController < ApplicationController

	before_filter :setup_friends

	def accept
		if @user.requested_friends.include?(@friend)
			Friendship.accept(@user, @friend)
			flash[:notice] = "Friendship Accepted"
		else
			flash[:notice] = "No Friendship Request"
		end
		redirect_to root_path
	end

	def decline
		if @user.requested_friends.include?(@friend)
			Friendship.breakup(@user, @friend)
			flash[:notice] = "Friendship Rejected"
		else
			flash[:notice] = "No Friendship Request"
		end
		redirect_to root_path
	end

	def cancel 
		if @user.pending_friends.include?(@friend)
      		Friendship.breakup(@user, @friend)
      		flash[:notice] = "Friendship Canceled"
    	else
      		flash[:notice] = "No Friendship request"
    	end
    	redirect_to root_path
  	end

	def delete
	    if @user.friends.include?(@friend)
	      Friendship.breakup(@user, @friend)
	      flash[:notice] = "Friendship Deleted"
	    else
	      flash[:notice] = "No Friendship request"
	    end
	    redirect_to root_path
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
			end
		end
	end

	def update
		accept
	end

	def create
		Friendship.request(@user, @friend)
		redirect_to root_path
	end

	private

		def setup_friends
			@user = current_user
			@friend = User.find_by_id(params[:friendship][:friend_id])
		end
		
end
