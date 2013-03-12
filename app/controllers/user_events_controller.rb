class UserEventsController < ApplicationController
	def destroy
		@userevent = UserEvent.find params[:id]
		if @userevent.destroy
			respond_to do |format|
				format.js
			end
		end
	end
end
