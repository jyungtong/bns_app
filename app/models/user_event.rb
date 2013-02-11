class UserEvent < ActiveRecord::Base
	attr_accessible :event, :user, :event_id

	belongs_to :user
	belongs_to :event

	validates_uniqueness_of :user_id, scope: [:event_id]

	#accepts_nested_attributes_for :events, :users
end
