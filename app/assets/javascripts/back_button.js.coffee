jQuery ->
	$('.back_button').click ->
		parent.history.back()
		false
