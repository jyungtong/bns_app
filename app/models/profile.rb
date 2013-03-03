class Profile < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :contact_number, :national_identity,
									:facebook_name
	belongs_to :user
end
