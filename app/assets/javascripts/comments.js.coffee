$(document).ready ->
	window.CommentDecorator = ->
		wrapper = (func) ->
			(e) ->
				e.preventDefault()
				e.stopPropagation()

				self = @

				$.post $(@).attr("href"), (data) ->
					func.call self, data

		$(".post__comments").on("click", ".vote__button--like, .vote__button--dislike", wrapper (data) -> 
				$comment = $(@).closest(".post__comment")
				$comment.find(".comment__votes")
					.text("Votes #{data.val}")
				if data.insulting
					$comment.addClass("post__comment--insulting")
		).on("click", ".comment__button--uninsult", wrapper (data) ->
			unless data.insulting
				$this = $(@)
				$this.closest(".post__comment")
					.removeClass("post__comment--insulting")
				$this.remove()
		)
	window.CommentDecorator()
