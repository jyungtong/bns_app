class ApplicationController < ActionController::Base
  protect_from_forgery

	protected
		# user must sign in to use the system
		def custom_user_auth
			unless student_signed_in? || admin_signed_in?
				redirect_to root_path, notice: "You have to sign in."
			end
		end

		# student must fill in their profile before joining any events
		def profile_must_completed
			if current_student
				user = current_student

				if user.profile.nil? || user.profile.is_empty?
					redirect_to profile_index_path, 
						alert: "Please fill in your profile before joining events."
				end
			end
		end
end
