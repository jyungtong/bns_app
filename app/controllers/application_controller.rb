class ApplicationController < ActionController::Base
  protect_from_forgery

	protected
		def custom_user_auth
			unless student_signed_in? || admin_signed_in?
				redirect_to root_path, notice: "You have to sign in."
			end
		end
end
