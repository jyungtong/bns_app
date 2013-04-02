class Event < ActiveRecord::Base
	attr_accessible :school_name, :start_place, :end_place, :event_date, 
									:start_time, :end_time, :max_student, :allowance_claim,
									:agency_in_charge, :backup_student, :hidden

	validates :school_name, :event_date, :start_time, :end_time, presence: :true

	validate :end_time_cannot_be_earlier_than_start_time

	has_many :user_events, dependent: :destroy
	has_many :users, through: :user_events

	default_scope order('event_date DESC')

	before_save :default_values

	# Set default values if nothing has input for max and backup student
	def default_values
		self.max_student ||= 0
		self.backup_student ||= 0
	end

	# Get event index by user type
	def self.get_event(user, page)
		if user.is_a? Student
			return Event.where(hidden: false).paginate(page: page), user.events.where(user_events: { join_status: true })
		else
			return Event.paginate(page: page), nil
		end
	end

	# overall seats required
	def total_student
		max_student + backup_student
	end

	# show how many seats available, show full if left 0
	def seats_available
		available = total_student - UserEvent.joined_students_count(self.id)

		if available > 0
			available
		else
			"FULL"
		end
	end

	# status for current event, for css styling
	def join_status(user_events)
		user_events.include?(self) ? "joined" : (is_expired? ? "expired" : "nojoin")
	end

	# whether the current event joined by the given student
	def include_student?(student)
		self.users.include?(student)
	end

	# student view of seats available
	def seats_available_over_total
		"#{seats_available} / #{total_student}"
	end

	def event_header
		"#{event_date} #{school_name}"
	end

	# admin view of seats available
	def seats_available_over_max_backup
		"#{seats_available} / #{max_student} + #{backup_student}"
	end

	# determine if an event is expired
	def is_expired?
		self.event_date < DateTime.now
	end

	# determine if an event is hidden by admin
	def is_hidden?
		self.hidden
	end

	# validate end time cannot be earlier than start time 
	def end_time_cannot_be_earlier_than_start_time
		if end_time && start_time 
			if end_time < start_time
				errors.add(:end_time, "End time should not be earlier than start time.")
			end
		end
	end
end
