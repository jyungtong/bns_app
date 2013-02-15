module EventHelper
	def formatted_date(d)
		d.strftime("%^A %^B %d %Y")
	end

	def formatted_time(t)
		t.strftime("%I:%M %p")
	end
end
