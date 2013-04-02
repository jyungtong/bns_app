module EventHelper
	def formatted_date(d)
		d.strftime("%d %b %Y (%a)")
	end

	def formatted_time(t)
		t.strftime("%H:%M")
	end

	def display_joined(str)
		str == "joined" ? "Joined" : "Not yet join"
	end

	def join_action(str)
		str == "joined" ? "Quit" : "Join"
	end

	def get_join_status(event)
		if student_signed_in?
			event.join_status(current_student)
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
      users = users | event.users.where(user_events: { join_status: true })
		end

		return users
	end

	# Get total participants joined for specific number of days
	def day_total(users, events, days)
		total = 0

		for user in users
      total += ((( user.events.where(user_events: { join_status: true }) & events ).count) == days) ? 1 : 0
		end

		return total
	end

	# Customed dynamic join quit event button
	def join_quit_button(status, event)
		if status == "joined" 
			button_to("Quit Event", quit_event_path(event), 
			{ confirm: "Are you sure to quit this event?",
				remote: true, 
				disabled: (event.seats_available == "FULL" && status != "joined") || event.is_expired? }) 
		else 
			button_to("Join Event", join_event_path(event),
			{ remote: true, 
				disabled: (event.seats_available == "FULL" && status != "joined") || event.is_expired? }) 
		end 
	end
end
