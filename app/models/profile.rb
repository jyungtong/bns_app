class Profile < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :contact_number, :national_identity,
									:facebook_name

	belongs_to :user

	validates :first_name, :last_name, :contact_number, :national_identity, 
						:facebook_name, presence: true, on: :update
	
	validates :contact_number, :national_identity, numericality: true, on: :update

	validates :contact_number, length: { in: 10..11 }, on: :update

	validates :national_identity, length: { is: 12 }, on: :update

	def full_name
		"#{first_name} #{last_name}"
	end
	
	def is_empty?
		first_name.blank? || last_name.blank? || contact_number.blank? || 
		national_identity.blank? || facebook_name.blank?
	end
end
