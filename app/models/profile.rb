class Profile < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :contact_number, :national_identity,
									:facebook_name
	belongs_to :user

	validates :first_name, :last_name, :contact_number, :national_identity, 
						:facebook_name, presence: true, on: :update

	def full_name
		"#{first_name} #{last_name}"
	end
	
	def is_empty?
		first_name.blank? || last_name.blank? || contact_number.blank? || 
		national_identity.blank? || facebook_name.blank?
	end
end
