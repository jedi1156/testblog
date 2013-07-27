$(document).ready ->
	wrapper = (func) ->
		(e) ->
			e.preventDefault()
			e.stopPropagation()

			self = this

			$.post $(this).attr("href"), (data) ->
				func.call self, data

	$(".post__comment").on("click", ".vote__button--like, .vote__button--dislike", wrapper (data) -> 
			console.log(data)
			$comment = $(this).closest(".post__comment")
			$comment.find(".comment__votes")
				.text("Votes #{data.val}")
			if data.insulting
				$comment.addClass("post__comment--insulting")
	).on("click", ".comment__button--uninsult", wrapper (data) ->
		console.log data
		unless data.insulting
			$this = $(this)
			console.log($this.closest(".post__comment"))
			$this.closest(".post__comment")
				.removeClass("post__comment--insulting")
			$this.remove()
	)





