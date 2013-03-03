class CreateEducationProfiles < ActiveRecord::Migration
  def change
    create_table :education_profiles do |t|
      t.string :current_university
      t.string :major_study
      t.integer :intake_year
      t.integer :graduation_year
			t.integer :user_id

      t.timestamps
    end
  end
end
