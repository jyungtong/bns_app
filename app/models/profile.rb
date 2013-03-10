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

	def ic_age_gender
		"#{national_identity} (#{age}, #{gender})"
	end

	def age
		id_year = national_identity.scan(/../).first.to_i
		exact_year = (2000 + id_year) > Time.now.year ? 1900 + id_year : 2000 + id_year
		Time.now.year - exact_year
	end

	def gender
		national_identity.scan(/./).last.to_i.odd? ? "Male" : "Female"
	end

	def contact_number_in_report
		contact_number.length == 10 ? contact_number_10 : contact_number_11
	end

	def contact_number_10
		contact_number.scan(/(\d{3})(\d{3})(\d{4})/).first.join(" ")
	end

	def contact_number_11
		contact_number.scan(/(\d{3})(\d{4})(\d{4})/).first.join(" ")
	end
end
