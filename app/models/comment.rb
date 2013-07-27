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
		votes.inject(0) do |res, it|
			res += it.val
		end
	end

	def user_vote(user_id)
		@vote ||= votes.detect do |v|
			v.user_id == user_id
		end
	end

	def dislikes
		@dislikes ||= votes.inject(0) do |res, it|
			if it.val < 0
				res += 1
			end
			res
		end
	end
end
