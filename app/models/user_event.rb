class UserEvent < ActiveRecord::Base
	attr_accessible :event, :user, :event_id

	belongs_to :user
	belongs_to :event

	validates_uniqueness_of :user_id, scope: [:event_id]

	validate :exceed_max_student
	validate :cannot_join_expired_event

	def exceed_max_student
		unless self.event.users.count < self.event.total_student
			errors.add(:event, "is full. Please try again later.")
		end
	end

	def timestamp
		self.created_at.localtime
	end

	def cannot_join_expired_event
		if self.event.event_date < DateTime.now
			errors.add(:event, "is expired. Please try other events.")
		end
	end

	#accepts_nested_attributes_for :events, :users
end
