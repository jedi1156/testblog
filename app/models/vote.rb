class Vote
	include Mongoid::Document

	field :val, type: Integer, default: 0

	belongs_to :comment
	belongs_to :user
end
