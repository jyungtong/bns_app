class ProfileController < ApplicationController
	before_filter :authenticate_student!

  def index
		@user ||= current_student
		
		unless @user.profile
			@user.profile = Profile.new
		end

		unless @user.education_profile
			@user.education_profile = EducationProfile.new
		end

		@profile = @user.profile
		@eduprofile = @user.education_profile
  end

	def update
		@profile = Profile.find params[:id]
		@profile.assign_attributes params[:profile]

		if @profile.save
			flash[:notice] = "You have successfully updated profile."
		else
			flash.now[:alert] = "Failed to save profile information."
		end

		redirect_to profile_index_path(tab: "profile")
	end
end
