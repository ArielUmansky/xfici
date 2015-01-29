class MicropostsController < ApplicationController

	before_filter :authenticate_user!
	before_filter :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:notice] = "Micropost created!"
			redirect_to root_path
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		flash[:notice] = "Micropost deleted!"
		redirect_to root_path
	end

	def update
		@micropost = Micropost.find(params[:id])
		@vote = params[:vote]
		if @vote == 'cancel'
			if @micropost.liked_by current_user
				@micropost.unliked_by current_user
			else
				@micropost.undisliked_by current_user
			end
		else
			if @vote=='true'
				#binding.pry
				@micropost.liked_by current_user
			else
				@micropost.disliked_by current_user
			end
		end
		
		#binding.pry
		respond_to do |format|
			format.json { render json: params}
			format.html { redirect_to root_path }
			format.js
		end
	end

	private

		def correct_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_path if @micropost.nil?
		end
end