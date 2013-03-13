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
			if event.is_expired?
				"expired"
			elsif event.is_hidden?
				"is-hidden"
			elsif !event.is_hidden? && event.seats_available == "FULL"
				"published full"
			else
				"published"
			end
		end
	end

	def get_all_users(events)
		users = []

		# To retrieve all users with union method
		for event in events
			users = users | event.users
		end

		return users
	end

	# Get total participants joined for specific number of days
	def day_total(users, events, days)
		total = 0

		for user in users
			total += ((( user.events & events ).count) == days) ? 1 : 0
		end

		return total
	end
end
