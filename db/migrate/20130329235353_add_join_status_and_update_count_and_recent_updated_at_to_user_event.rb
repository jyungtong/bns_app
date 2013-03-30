class AddJoinStatusAndUpdateCountAndRecentUpdatedAtToUserEvent < ActiveRecord::Migration
  def change
    add_column :user_events, :join_status, :boolean, default: true
    add_column :user_events, :update_count, :integer, default: 0
    add_column :user_events, :recent_updated_at, :datetime
  end
end
