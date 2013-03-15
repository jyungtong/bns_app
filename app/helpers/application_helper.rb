module ApplicationHelper
	def eduprofile
		@user = current_student

		unless @user.education_profile
			@user.education_profile = EducationProfile.new
		end

		@eduprofile = @user.education_profile
	end
end
