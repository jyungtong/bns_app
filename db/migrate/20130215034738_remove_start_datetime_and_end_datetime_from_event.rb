class RemoveStartDatetimeAndEndDatetimeFromEvent < ActiveRecord::Migration
  def up
    remove_column :events, :start_datetime
    remove_column :events, :end_datetime
  end

  def down
    add_column :events, :end_datetime, :datetime
    add_column :events, :start_datetime, :datetime
  end
end
