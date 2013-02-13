module EventHelper
	def formatted_datetime(dt)
		dt.strftime("%^A %^B %d, %Y %I:%M %p")
	end
end
