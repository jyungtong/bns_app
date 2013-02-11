class ProfileController < ApplicationController
	before_filter :authenticate_student!

  def index
		@user = current_student
		
		unless @user.profile
			@user.profile = Profile.create
		end
  end

	def update
		if current_student.profile.update_attributes params[:profile]
			redirect_to profile_index_path, notice: "You have successfully updated profile."
		else
			flash.now[:error] = "Failed to update profile."
			render action: "new"
		end
	end
end
