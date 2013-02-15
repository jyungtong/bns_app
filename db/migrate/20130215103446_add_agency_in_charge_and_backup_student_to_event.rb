class AddAgencyInChargeAndBackupStudentToEvent < ActiveRecord::Migration
  def change
    add_column :events, :agency_in_charge, :string
    add_column :events, :backup_student, :integer
  end
end
