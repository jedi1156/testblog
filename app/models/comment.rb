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
		@val ||= votes.inject(0) do |res, it|
			res += it.val
		end
	end

	def user_vote(user_id)
		@vote ||= votes.detect do |v|
			v.user_id == user_id
		end
	end
end
