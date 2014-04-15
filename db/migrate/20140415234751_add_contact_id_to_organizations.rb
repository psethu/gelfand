class AddContactIdToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :contact_id, :integer
  end
end
