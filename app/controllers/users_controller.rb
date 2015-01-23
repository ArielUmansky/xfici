class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update, :show, :destroy, :friends, :requested_friends, :pending_friends]
  before_filter :admin_user, only: :destroy

  def show
  	@user = User.find(params[:id])
  	@microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
  	@users = User.paginate(page: params[:page])
  end

  def destroy
  	User.find(params[:id]).destroy
  	flash[:notice] = "User destroyed."
  	redirect_to users_path
  end

  def friends
  	@title = "Friends"
  	@user = User.find(params[:id])
  	@users = @user.friends.paginate(page: params[:page])
  	render 'show_friends'
  end

  def pending_friends
  	@title = "Pending Friendship Requests"
  	@user = User.find(params[:id])
  	@users = @user.pending_friends.paginate(page: params[:page])
  	render 'show_friends'
  end

  def requested_friends
  	@title = "Requested Friendships"
  	@user = User.find(params[:id])
  	@users = @user.requested_friends.paginate(page: params[:page])
  	render 'show_friends'
  end

  private 

  	def admin_user
  		redirect_to(root_path) unless current_user.admin?
  	end
end
