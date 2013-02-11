class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
			t.string :first_name
			t.string :last_name
			t.string :contact_number
			t.string :national_id
			t.integer :user_id

      t.timestamps
    end
  end
end
