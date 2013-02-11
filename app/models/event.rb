class Event < ActiveRecord::Base
	attr_accessible :school_name, :start_place, :end_place, :start_datetime, 
									:end_datetime, :max_student, :allowance_claim

	has_many :user_events
	has_many :users, through: :user_events

	def seats_available
		self.max_student - UserEvent.where(event_id: self.id).count
	end

	def event_action(user)
		unless self.users.include?(user)
			"join"
		else
			"quit"
		end
	end
end
