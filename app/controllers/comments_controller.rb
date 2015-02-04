class CommentsController < ApplicationController

	def create
		@content = params[:comment][:content]
		if (!@content.blank?)
			@micropost = Micropost.find(params[:micropost_id])
			@comment = @micropost.comments.create(user: current_user, content: @content)
		end
		redirect_to root_path
	end

	def destroy
		@micropost = Micropost.find(params[:micropost_id])
		@comment = @micropost.comments.find(params[:id])
		@comment.destroy
		redirect_to root_path
	end

	def update 
		@comment = Comment.find(params[:id])
		@comment.update_attributes(params[:comment])
		respond_to do |format|
			format.html { redirect_to root_path }
			format.json { render json: @comment }
		end
	end

end
