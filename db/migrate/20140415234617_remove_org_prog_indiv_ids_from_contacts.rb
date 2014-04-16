class RemoveOrgProgIndivIdsFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :individual_id, :integer
    remove_column :contacts, :program_id, :integer
    remove_column :contacts, :organization_id, :integer
  end
end
