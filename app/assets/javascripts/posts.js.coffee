$(document).ready ->

	$(".post__comment").on "click", ".vote_button--like, .vote_button--dislike", (e) ->
		e.preventDefault()

		$this = $(this)

		$.post $this.attr("href"), (data) ->
			$this.closest(".post__comment")
				.find(".comment__votes")
				.text("Votes #{data.val}")
