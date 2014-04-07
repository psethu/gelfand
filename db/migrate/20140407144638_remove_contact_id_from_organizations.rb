class RemoveContactIdFromOrganizations < ActiveRecord::Migration
  def change
    remove_column :organizations, :contact_id, :integer
  end
end
