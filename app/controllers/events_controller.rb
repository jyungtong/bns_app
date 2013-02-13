class EventsController < ApplicationController
	before_filter :custom_user_auth

  def index
		@user = current_student || current_admin
		@events ||= Event.all
  end

	def show
		@event ||= Event.find params[:id]
		@action = @event.event_action(current_student)
	end

	def new
		redirect_to root_path if student_signed_in?
		@event = Event.new
	end

	def joined
		@events = current_student.events
	end

	def create
		event = Event.new params[:event]
		if event.save
			redirect_to events_path, notice: "Event is successfully created."
		else
			flash.now[:error] = "Event failed to create."
			render 'new'
		end
	end

	def join
		userevent = current_student.user_events.build(event_id: params[:id])
		if userevent.save
			redirect_to userevent.event, notice: "You have successfully joined this event."
		else
			redirect_to userevent.event, error: "Failed to joined this event."
		end
	end

	def quit
		userevent = UserEvent.where(user_id: current_student.id, event_id: params[:id]).first
		if userevent.destroy
			redirect_to userevent.event, notice: "You have quit this event."
		else
			redirect_to userevent.event, error: "Unable to quit this event."
		end
	end
end
