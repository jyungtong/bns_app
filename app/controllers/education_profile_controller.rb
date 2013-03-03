class EducationProfileController < ApplicationController
	before_filter :authenticate_student!

  def index
		@user = current_student
		
		unless @user.education_profile
			@user.education_profile = EducationProfile.create
		end
  end

	def update
		if current_student.education_profile.update_attributes params[:education_profile]
			redirect_to education_profile_index_path, notice: "You have successfully updated education profile."
		else
			flash.now[:error] = "Failed to update education profile."
			render action: "new"
		end
	end
end
