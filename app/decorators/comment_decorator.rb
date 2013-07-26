class CommentDecorator < Draper::Decorator
	decorate :comment
	delegate_all

	def multiline_body
		@body ||= body.gsub(/\n/, "<br>")
	end
end
