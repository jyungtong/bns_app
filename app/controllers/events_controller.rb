class EventsController < ApplicationController
	before_filter :custom_user_auth

  def index
		@user = current_student || current_admin
		@events = Event.all
  end

	def show
		@event = Event.find params[:id]
		@action = @event.event_action(current_student)
	end

	def new
		redirect_to root_path if student_signed_in?
		@event = Event.new
	end

	def joined
		# To show the student's joined events
		@events = current_student.events
	end

	def create
		event = Event.new params[:event]
		if event.save
			redirect_to event_path(event), notice: "Event is successfully created."
		else
			#flash.now[:error] = "Event failed to create."
			redirect_to :back
		end
	end

	def edit
		redirect_to root_path unless admin_signed_in?
		@event = Event.find params[:id]
	end

	def update
		event = Event.find params[:id]
		if event.update_attributes params[:event]
			redirect_to event, notice: "Event has been successfully updated."
		else
			flash.now[:error] = "Event failed to update."
			render 'edit'
		end
	end

	def destroy
		unless admin_signed_in?
			redirect_to root_path
			return
		end

		event = Event.find params[:id]
		if event.destroy
			redirect_to root_path, notice: "Event has been successfully deleted."
		else 
			redirect_to root_path, error: "Event failed to delete."
		end
	end

	def join
		userevent = current_student.user_events.build(event_id: params[:id])
		if userevent.save
			redirect_to :back, notice: "You have successfully joined this event."
		else
			redirect_to :back, alert: userevent.errors.full_messages[0]
		end
	end

	def quit
		userevent = UserEvent.where(user_id: current_student.id, event_id: params[:id]).first
		if userevent.destroy
			redirect_to :back, notice: "You have quit this event."
		end
	end
end
