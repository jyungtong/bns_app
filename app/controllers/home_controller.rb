class HomeController < ApplicationController
  def index
		if student_signed_in? || admin_signed_in?
			redirect_to events_path
		end
  end
end
