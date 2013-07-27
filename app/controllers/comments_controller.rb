class CommentsController < ApplicationController
	before_filter :authenticate_user!

	expose_decorated(:post)
	expose_decorated(:comment)
	expose_decorated(:comments) { post.comments }
	expose(:vote) { comment.user_vote(current_user.id) || Vote.new(comment_id: comment.id, user_id: current_user.id) }

	def create
		comment.user_id = current_user.id
		if comment.save
			redirect_to comment.post, flash: { notice: "New comment added" }
		else
			render :new
		end
	end

	def destroy
		if current_user.id == comment.user_id
			comment.destroy 
			redirect_to comment.post, flash: { notice: "Comment deleted" }
		else
			redirect_to comment.post, flash: { error: "Can't touch this" }
		end
	end

	def update
		if comment.save
			redirect_to comment.post, flash: { notice: "Comment edited" }
		else
			render :edit
		end
	end

	def like
		vote.val = 1
		handle_vote
	end

	def dislike
		vote.val = -1
		handle_vote
	end

	def uninsult
		if current_user.owner? post
			comment.insulting = false
			comment.save
			render json: {
				status: :ok,
				message: "updated",
				insulting: comment.insulting
			}
		else
			render json: {
				status: :forbidden,
				message: "rejected",
				insulting: comment.insulting
			}
		end
	end

private
	def handle_vote
		if vote.save
			if !comment.insulting && comment.dislikes >= 3
				comment.insulting = true
				comment.save
			end
			render json: {
				status: :ok,
				message: "updated",
				val: comment.votes_val,
				insulting: comment.insulting
			}
		else
			render json: {
				status: :conflict,
				message: "rejected",
				val: comment.votes_val
			}
		end
	end
end
