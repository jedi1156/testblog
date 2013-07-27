class Comment
	include Mongoid::Document
	include Mongoid::Timestamps

	field :body, type: String
	field :insulting, type: Boolean, default: false

	validates :body, presence: true

	belongs_to :user
	belongs_to :post
	has_many :votes

	def votes_val
		votes = Vote.where(comment: self)
		votes.inject(0) { |res, it| res += it.val }
	end

	def user_vote(user_id)
		@vote ||= votes.detect { |v| v.user_id == user_id }
	end

	def dislikes
		@dislikes ||= votes.inject(0) { |res, it|
			res += 1 if it.val < 0 
			res
		}
	end
end
