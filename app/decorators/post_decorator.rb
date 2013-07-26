class PostDecorator < Draper::Decorator
	decorates :post
	delegate_all

	def friendly_title
		title.gsub(' ', '-').downcase
	end


	def multiline_body
		@body ||= body.gsub(/\n/, "<br>")
	end

	def truncated_body
		h.raw h.truncate(multiline_body, length: 200, omission: "...")
	end
end
