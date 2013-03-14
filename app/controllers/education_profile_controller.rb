class EducationProfileController < ApplicationController
	before_filter :authenticate_student!

  def index
		@user ||= current_student
		
		unless @user.education_profile
			@user.education_profile = EducationProfile.new
		end

		@eduprofile = @user.education_profile
  end

	def update
		@eduprofile = EducationProfile.find params[:id]
		@eduprofile.assign_attributes params[:education_profile]

		if @eduprofile.save
			flash[:notice] = "You have successfully updated education profile."
		else
			flash.now[:alert] = "Failed to save education profile information."
		end

		redirect_to profile_index_path(tab: "edu")
	end
end
