class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
			t.string :school_name
			t.string :start_place
			t.string :end_place
			t.datetime :start_datetime
			t.datetime :end_datetime
			t.integer :max_student
			t.string :allowance_claim

      t.timestamps
    end
  end
end
