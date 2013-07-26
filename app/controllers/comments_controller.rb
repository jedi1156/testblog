class CommentsController < ApplicationController
	expose_decorated(:post)
	expose_decorated(:comment)
	expose_decorated(:comments) { post.comments }

	def create
		comment.user_id = current_user.id
		if comment.save
			redirect_to comment.post
		else
			render :new
		end
	end

	def destroy
		comment.destroy if current_user.id == comment.user
		render comment.post
	end

	def update
		if comment.save
			render comment.post
		else
			render :edit
		end
	end
end
