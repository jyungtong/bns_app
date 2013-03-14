class AddCurrentUniversityAndMajorStudyAndIntakeYearAndGraduationYearToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :current_university, :string
    add_column :profiles, :major_study, :string
    add_column :profiles, :intake_year, :integer
    add_column :profiles, :graduation_year, :integer
  end
end
