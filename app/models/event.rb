class Event < ActiveRecord::Base
	attr_accessible :school_name, :start_place, :end_place, :event_date, 
									:start_time, :end_time, :max_student, :allowance_claim,
									:agency_in_charge, :backup_student

	#validates_presence_of :school_name, :event_date, :start_time, :end_time
	validates :school_name, :event_date, :start_time, :end_time, presence: :true

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

	def event_action(user)
		unless users.include?(user)
			"join"
		else
			"quit"
		end
	end
end
