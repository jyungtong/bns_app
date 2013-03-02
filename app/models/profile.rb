class Profile < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :contact_number, :national_identity
	belongs_to :user
	has_one :education_profile
end
