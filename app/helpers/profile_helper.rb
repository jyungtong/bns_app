module ProfileHelper
	def telco_options
		["010", "011", "012", "013", "014", "016", "017", "018", "019"]
	end

	def university_options
		["APU", "TARC", "HELP", "INTI", "TAYLOR", "UTAR", "OTHERS"]
	end

  def year_options
    year_range = 5
    year = Time.now.year
    ((year-year_range)..(year+year_range)).to_a
  end
end
