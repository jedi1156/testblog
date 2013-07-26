class Comment
	include Mongoid::Document
	include Mongoid::Timestamps

	field :body, type: String
	field :vote_up, type: int, default: 0
	field :vote_down, type: int, default: 0
	field :insulting, type: Boolean, default: false

	validates :body, presence: true

	belongs_to :user
	belongs_to :post
end
