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
end
