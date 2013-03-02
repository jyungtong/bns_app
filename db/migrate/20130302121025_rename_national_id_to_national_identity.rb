class RenameNationalIdToNationalIdentity < ActiveRecord::Migration
  def up
		rename_column :profiles, :national_id, :national_identity
  end

  def down
		rename_column :profiles, :national_identity, :national_id
  end
end
