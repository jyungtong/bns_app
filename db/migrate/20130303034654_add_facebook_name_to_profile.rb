class AddFacebookNameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :facebook_name, :string
  end
end
