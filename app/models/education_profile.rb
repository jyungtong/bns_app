class EducationProfile < ActiveRecord::Base
  attr_accessible :current_university, :graduation_year, :intake_year, :major_study
	belongs_to :user

	validates :current_university, :major_study, presence: true, on: :update
end
