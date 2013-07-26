class CommentsController < ApplicationController
	before_filter :authenticate_user!

	expose_decorated(:post)
	expose_decorated(:comments) { post.comments }
	expose_decorated(:comment)
	expose(:votes) { comment.votes }

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

	def like
		vote = get_vote
		vote.val = 1
		handle_vote(vote)
	end

	def dislike
		vote = get_vote
		vote.val = -1
		handle_vote(vote)
	end

private
	def get_vote
		comment.user_vote(current_user.id) || Vote.new(comment_id: comment.id, user_id: current_user.id)
	end

	def handle_vote(vote)
		if vote.save
			render json: {
				status: :ok,
				message: "updated",
				val: comment.votes_val
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
