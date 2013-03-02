module EventHelper
	def formatted_date(d)
		d.strftime("%d %b %Y (%a)")
	end

	def formatted_time(t)
		t.strftime("%I:%M %p")
	end

	def display_joined(str)
		str == "joined" ? "Joined" : "Not yet join"
	end

	def join_action(str)
		str == "joined" ? "Quit" : "Join"
	end

	def get_join_status(event, user_events)
		if user_events
			event.join_status(user_events)
		else
			"admin"
		end
	end
end
