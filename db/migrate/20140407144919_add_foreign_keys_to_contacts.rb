class AddForeignKeysToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :individual_id, :integer
    add_column :contacts, :organization_id, :integer
    add_column :contacts, :program_id, :integer
  end
end
