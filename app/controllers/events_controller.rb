class EventsController < ApplicationController
	before_filter :custom_user_auth, :profile_must_completed
	before_filter :must_be_admin, only: [ :new, :edit, :destroy, :create, :update ]

  def index
		@events, @user_events = Event.get_event(current_student || current_admin)
  end

=begin
	def show
		@event = Event.find params[:id]
		@action = @event.event_action(current_student)
	end
=end

	def new
		@event = Event.new 
	end

	# To show the student's joined events
	def joined
		@user_events = @events = current_student.events
	end

	def create
		@event = Event.new params[:event]
		if @event.save
			redirect_to events_path, notice: "Event is successfully created."
		else
			render "new"
		end
	end

	def edit
		@event = Event.find params[:id]
	end

	def update
		@event = Event.find params[:id]
		if @event.update_attributes params[:event]
			flash.now[:notice] = "Event has been successfully updated."
			render "edit"
		else
			# flash.now[:error] = "Event failed to update."
			render "edit"
		end
	end

	def destroy
		@event = Event.find params[:id]
		if @event.destroy
			redirect_to root_path, notice: "Event has been successfully deleted."
		else 
			redirect_to root_path, error: "Event failed to delete."
		end
	end

	def join
		@userevent = current_student.user_events.build(event_id: params[:id])

		respond_to do |format|
			if @userevent.save
				flash.now[:notice] = "You have successfully joined the event."
				format.html { redirect_to :back, notice: "You have successfully joined the event." }
				format.js
			else
				format.html { redirect_to :back, alert: @userevent.errors.full_messages.first }
				format.js { render "fail_join.js.erb", userevent: @userevent }
			end
		end
	end

	def quit
		@userevent = UserEvent.where(user_id: current_student.id, event_id: params[:id]).first

		respond_to do |format|
			if @userevent.destroy
				flash.now[:notice] = "You have quit the event."
				format.html { redirect_to :back, notice: "You have quit the event." }
				format.js
			end
		end
	end

	def show_participants
		@events = Event.find params[:event_ids]
	end

	private
		def must_be_admin
			unless admin_signed_in?
				redirect_to root_path
				return
			end
		end
end
