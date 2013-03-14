class ProfileController < ApplicationController
	before_filter :authenticate_student!

  def index
		@user ||= current_student
		
		unless @user.profile
			@user.profile = Profile.new
		end

		@profile = @user.profile
  end

	def update
		@profile = Profile.find params[:id]
		@profile.assign_attributes params[:profile]

		if @profile.save
			flash.now[:notice] = "You have successfully updated profile."
		else
			flash.now[:alert] = "Failed to save profile information."
		end

		#redirect_to profile_index_path(tab: "profile")
		render 'index'
	end
end
