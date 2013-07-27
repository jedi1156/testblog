$(document).ready ->

	$(".post__comment").on "click", ".vote__button--like, .vote__button--dislike", (e) ->
		e.preventDefault()
		e.stopPropagation()

		$this = $(this)

		$.post $this.attr("href"), (data) ->
			$this.closest(".post__comment")
				.find(".comment__votes")
				.text("Votes #{data.val}")
