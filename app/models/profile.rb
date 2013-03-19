class Profile < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :contact_number, :national_identity,
									:facebook_name, :contact_number_prefix, :contact_number_affix,
									:current_university, :graduation_year, :intake_year, :major_study

	attr_accessor :contact_number_prefix, :contact_number_affix

	belongs_to :user

	before_validation :concat_contact_number

	validates :first_name, :last_name, :national_identity, :facebook_name,
						:current_university, :major_study,	presence: true, on: :update
	
	validates :national_identity, numericality: true, length: { is: 12 }, on: :update

	validates :contact_number, numericality: true, on: :update

	validates :intake_year, :graduation_year, numericality: { only_integer: true },
						allow_blank: true, on: :update

	validate :valid_year, :contact_number_validate, on: :update

	def full_name
		"#{first_name} #{last_name}"
	end
	
	def is_empty?
		first_name.blank? || last_name.blank? || contact_number.blank? || 
		national_identity.blank? || facebook_name.blank? || 
		current_university.blank? || major_study.blank?
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
		national_identity.scan(/./).last.to_i.odd? ? "M" : "F"
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

	def contact_number_prefix
		return contact_number[0..2] if contact_number
		@contact_number_prefix 
	end

	def contact_number_affix
		return contact_number[3..-1] if contact_number
		@contact_number_affix 
	end

	def contact_number_prefix=(number)
		@contact_number_prefix = number
	end

	def contact_number_affix=(number)
		@contact_number_affix = number
	end

	def concat_contact_number
		if @contact_number_prefix && @contact_number_affix
			self.contact_number = @contact_number_prefix + @contact_number_affix
		end
	end

	def contact_number_validate
		if @contact_number_prefix == "011"
			unless @contact_number_affix.length == 8
				errors.add(:contact_number, "011 should have 8 digits only.")
			end
		else
			unless @contact_number_affix.length == 7
				errors.add(:contact_number, "#{@contact_number_prefix} should have 7 digits only.")
			end
		end
	end

	def valid_year
		if graduation_year && intake_year
			if graduation_year < intake_year
				errors.add(:graduation_year, "Graduation year should not less than intake year.")
			end
		end
	end
end
