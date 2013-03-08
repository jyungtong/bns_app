class EducationProfile < ActiveRecord::Base
  attr_accessible :current_university, :graduation_year, :intake_year, :major_study
	belongs_to :user

	validates :current_university, :major_study, presence: true, on: :update

	validates :intake_year, :graduation_year, numericality: { only_integer: true }, 
						on: :update

	validate :valid_year, on: :update

	def valid_year
		if graduation_year < intake_year
			errors.add(:graduation_year, "Graduation year should not less than intake year.")
		end
	end
end
