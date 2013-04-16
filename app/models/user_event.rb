class UserEvent < ActiveRecord::Base
  attr_accessible :event, :user, :event_id, :user_id, :join_status

	belongs_to :user
	belongs_to :event

  before_save :refresh_update_info

	validates_uniqueness_of :user_id, scope: [:event_id]

  validate :exceed_max_student, :cannot_join_expired_event
  validate :student_cannot_flood_join, on: :update

	def timestamp
		self.created_at
	end

	def self.show_participants(event_id)
		self.select("ue.*")
				.from("user_events AS ue")
				.joins("JOIN profiles AS p ON p.user_id = ue.user_id")
				.order("p.first_name ASC")
				.where("ue.join_status = ? AND ue.event_id in (?)", true, event_id)
	end

  def self.joined_students(event_id)
		subquery = self.select("DISTINCT(ue.user_id), p.first_name")
								.from("user_events AS ue")
								.joins("JOIN profiles AS p ON p.user_id = ue.user_id")
								.where("ue.join_status = ? AND ue.event_id IN (?)", true, event_id)
								.to_sql
		
		self.select("sub.*")
				.from("(#{subquery}) sub")
				.order("sub.first_name ASC")
  end

  def self.joined_students_count(event_id)
    self.where(event_id: event_id, join_status: true).count
  end

  def refresh_update_info
    if !self.updated_at || Time.now - self.updated_at > APP_CONFIG["flood_minutes"].minutes 
      self.recent_updated_at = Time.now 
      self.update_count = 0
    end

    if Time.now - self.recent_updated_at < APP_CONFIG["flood_minutes"].minutes
      self.update_count += 1
    end
  end

	def exceed_max_student
    if self.join_status
      unless UserEvent.joined_students_count(self.event.id) < self.event.total_student
        errors.add(:event, "is full. Please try again later.")
      end
    end
	end

	def cannot_join_expired_event
		if self.event.is_expired?
			errors.add(:event, "is expired. Please try other events.")
		end
	end

  def student_cannot_flood_join
    if Time.now - self.recent_updated_at < APP_CONFIG["flood_unrestrict"].minutes && self.update_count > APP_CONFIG["flood_count"]
      errors.add(:event, "is flooded. Please try again after #{APP_CONFIG["flood_unrestrict"]} minutes.")
    end
  end

	#accepts_nested_attributes_for :events, :users
end
