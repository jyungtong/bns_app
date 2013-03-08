class ProfileController < ApplicationController
	before_filter :authenticate_student!

  def index
		@user ||= current_student
		
		unless @user.profile
			@user.profile = Profile.create
		end

		@profile = @user.profile
  end

	def update
		@user = User.find params[:id]
		@profile = @user.profile
		@profile.assign_attributes params[:profile]

		if @profile.save
			flash.now[:notice] = "You have successfully updated profile."
		else
			flash.now[:alert] = "Failed to save profile information."
		end

		render "index"
	end
end
