class Event < ActiveRecord::Base
	attr_accessible :school_name, :start_place, :end_place, :event_date, 
									:start_time, :end_time, :max_student, :allowance_claim,
									:agency_in_charge, :backup_student

	validates :school_name, :event_date, :start_time, :end_time, presence: :true

	validate :end_time_cannot_be_earlier_than_start_time

	has_many :user_events
	has_many :users, through: :user_events

	default_scope order('event_date DESC')

	def total_student
		max_student + backup_student
	end

	def seats_available
		available = total_student - UserEvent.where(event_id: self.id).count

		if available > 0
			available
		else
			"FULL"
		end
	end

	def join_status(user_events)
		user_events.include?(self) ? "joined" : "nojoin"
	end

	def include_student?(student)
		self.users.include?(student)
	end

	def seats_available_over_total
		"#{seats_available} / #{total_student}"
	end

	def event_header
		"#{event_date} #{school_name}"
	end

	def seats_available_over_max_backup
		"#{seats_available} / #{max_student} + #{backup_student}"
	end

	def end_time_cannot_be_earlier_than_start_time
		if end_time < start_time
			errors.add(:end_time, "End time should not be earlier than start time.")
		end
	end
end
